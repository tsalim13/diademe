import 'dart:io';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:diademe/Bloc/Database/database_bloc.dart';
import 'package:diademe/Bloc/Database/database_state.dart';
import 'package:diademe/Models/Saler.dart';
import 'package:diademe/Models/SalerReview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import "package:collection/collection.dart";
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:expandable/expandable.dart';

class Chart extends StatefulWidget {
  final List<Saler?> selectedSalers;
  final PickerDateRange? range;
  final bool isGlobal;

  const Chart(
      {Key? key,
      required this.selectedSalers,
      required this.range,
      required this.isGlobal})
      : super(key: key);
  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  late LoadedDatabaseState _databaseState;

  List<Saler> _salers = [];
  bool isLoading = true;

  List<SalerReview> _salersReviews = [];

  Map<int, List<SalerReview>> _salersReviewsMap = {};
  Map<DateTime, List<SalerReviewWithDateTime>> _salerReviewWithDateTimeMap = {};

  DateTime _firstDate = DateTime(2021);
  DateTime _lastDate = DateTime.now().add(Duration(days: 1));

  List<charts.Series<dynamic, String>> seriesList = [];
  List<charts.Series<dynamic, DateTime>> seriesListDatetime = [];

  late ButtonStyle style;

  @override
  void initState() {
    _databaseState =
        BlocProvider.of<DatabaseBloc>(context).state as LoadedDatabaseState;
    fetchSalers();

    super.initState();
  }

  Future<void> fetchSalers() async {
    _salers = await _databaseState.salerDao.findAllActifSalers();
    if (widget.isGlobal)
      fetchSalersReviewsGlobal();
    else
      fetchSalersReviewsDetail();
  }

  Future<void> fetchSalersReviewsDetail() async {
    List<int> selectedSalersIds = [];
    selectedSalersIds = widget.selectedSalers.map((e) => e!.id!).toList();

    if (widget.range != null) {
      int start = widget.range!.startDate!.millisecondsSinceEpoch;
      int end = widget.range!.endDate!.millisecondsSinceEpoch +
          Duration(hours: 23, minutes: 59, seconds: 59).inMilliseconds;

      _salersReviews = await _databaseState.salerReviewDao
          .findSalerReviewBySalerIdDateRange(selectedSalersIds, start, end);
    } else {
      _salersReviews = await _databaseState.salerReviewDao
          .findSalerReviewBySalerId(selectedSalersIds);
    }

    List<SalerReviewWithDateTime> salerReviewWithDateTime = [];
    salerReviewWithDateTime = _salersReviews
        .map((e) => SalerReviewWithDateTime(
            e, DateUtils.dateOnly(DateTime.fromMillisecondsSinceEpoch(e.date))))
        .toList();

    // _salerReviewWithDateTimeMap = groupBy(salerReviewWithDateTime,
    //     (SalerReviewWithDateTime review) => review.datetime);

    // _salersReviewsMap =
    //     groupBy(_salersReviews, (SalerReview review) => review.salerId);

    List<DateTimeChartReview> reviews = [];

    setState(() {
      Map<int, List<SalerReviewWithDateTime>> map = groupBy(
          salerReviewWithDateTime,
          (SalerReviewWithDateTime review) => review.salerReview.salerId);

      map.forEach((salerId, value) {
        _salerReviewWithDateTimeMap =
            groupBy(value, (SalerReviewWithDateTime review) => review.datetime);
        reviews = [];
        _salerReviewWithDateTimeMap.forEach((key, value) {
          var sum = value
              .map((sr) => sr.salerReview.mark)
              .reduce((value, element) => value + element);

          reviews.add(DateTimeChartReview(
            key,
            average: double.parse((sum / value.length).toStringAsFixed(2)),
          ));
        });

        seriesListDatetime.add(charts.Series<DateTimeChartReview, DateTime>(
          id: "Note moyenne " +
              _salers.firstWhere((element) => element.id == salerId).name,
          domainFn: (DateTimeChartReview rvws, _) => rvws.datetime,
          measureFn: (DateTimeChartReview rvws, _) => rvws.average,
          data: reviews,
        ));
      });

      isLoading = false;
    });
  }

  Future<void> fetchSalersReviewsGlobal() async {
    List<int> selectedSalersIds = [];
    selectedSalersIds = widget.selectedSalers.map((e) => e!.id!).toList();

    if (widget.range != null) {
      int start = widget.range!.startDate!.millisecondsSinceEpoch;
      int end = widget.range!.endDate!.millisecondsSinceEpoch +
          Duration(hours: 23, minutes: 59, seconds: 59).inMilliseconds;

      _salersReviews = await _databaseState.salerReviewDao
          .findSalerReviewBySalerIdDateRange(selectedSalersIds, start, end);
    } else {
      _salersReviews = await _databaseState.salerReviewDao
          .findSalerReviewBySalerId(selectedSalersIds);
    }

    _salersReviewsMap =
        groupBy(_salersReviews, (SalerReview review) => review.salerId);

    List<ChartReview> reviews = [];

    setState(() {
      _salersReviewsMap.forEach((key, value) {
        var sum = value
            .map((sr) => sr.mark)
            .reduce((value, element) => value + element);
        int nbrComment =
            value.where((element) => element.comment.isNotEmpty).length;
        reviews.add(ChartReview(
            _salers.firstWhere((element) => element.id == key).name,
            nbr: value.length,
            average: double.parse((sum / value.length).toStringAsFixed(2)),
            nbrComment: nbrComment));
      });

      seriesList.add(
        new charts.Series<ChartReview, String>(
          id: 'Nombre de notes',
          domainFn: (ChartReview rvws, _) => rvws.salerName,
          measureFn: (ChartReview rvws, _) => rvws.nbr!,
          data: reviews,
        ),
      );

      seriesList.add(
        new charts.Series<ChartReview, String>(
          seriesColor: charts.ColorUtil.fromDartColor(Colors.green),
          id: 'Note moyenne',
          domainFn: (ChartReview rvws, _) => rvws.salerName,
          measureFn: (ChartReview rvws, _) => rvws.average!,
          data: reviews,
        ),
      );

      seriesList.add(
        new charts.Series<ChartReview, String>(
          seriesColor: charts.ColorUtil.fromDartColor(Colors.orange),
          id: 'Nombre de commentaires',
          domainFn: (ChartReview rvws, _) => rvws.salerName,
          measureFn: (ChartReview rvws, _) => rvws.nbrComment!,
          data: reviews,
        ),
      );

      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    style = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20),
        elevation: 15,
        primary: Theme.of(context).primaryColor.withOpacity(0.7),
        onPrimary: Colors.black);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('Graphiques'),
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.isGlobal
                          ? Container(
                              height: MediaQuery.of(context).size.height - 56,
                              child: charts.BarChart(
                                seriesList,
                                animate: true,
                                barGroupingType: charts.BarGroupingType.grouped,
                                behaviors: [new charts.SeriesLegend()],
                              ),
                            )
                          : Container(
                              height: MediaQuery.of(context).size.height - 56,
                              child: charts.TimeSeriesChart(
                                seriesListDatetime,
                                animate: true,
                                // Optionally pass in a [DateTimeFactory] used by the chart. The factory
                                // should create the same type of [DateTime] as the data provided. If none
                                // specified, the default creates local date time.
                                dateTimeFactory:
                                    const charts.LocalDateTimeFactory(),
                                behaviors: [new charts.SeriesLegend()],
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Divider(thickness: 2),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text("Commentaires: ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _salers.length,
                            separatorBuilder: (context, int index) {
                              return Divider();
                            },
                            itemBuilder: (context, int index) {
                              Saler s = _salers[index];
                              List<SalerReview> rws = _salersReviews
                                  .where((element) =>
                                      element.salerId == s.id &&
                                      element.comment.isNotEmpty)
                                  .toList();
                              return ExpandablePanel(
                                header: Text(s.name,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400)),
                                collapsed: Container(),
                                expanded: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 15, left: 15, bottom: 10),
                                    child: ListView.separated(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: rws.length,
                                        separatorBuilder: (context, int index) {
                                          return Divider();
                                        },
                                        itemBuilder: (context, int i) {
                                          return Row(
                                            children: [
                                              Container(
                                                width: (MediaQuery.of(context).size.width - 55)*0.5,
                                                child: Text(rws[i].comment)
                                              ),
                                              Spacer(),
                                              RatingBar(
                                                ignoreGestures: true,
                                                initialRating:
                                                    rws[i].mark.toDouble(),
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: false,
                                                itemCount: 5,
                                                itemPadding:
                                                    EdgeInsets.only(right: 1),
                                                ratingWidget: RatingWidget(
                                                  full: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Icon(Icons.star_border,
                                                          size: 250,
                                                          color: Colors.amber),
                                                      Icon(Icons.star,
                                                          size: 120,
                                                          color: Colors.amber),
                                                    ],
                                                  ),
                                                  half: Icon(Icons.star_border,
                                                      size: 90,
                                                      color: Colors.amber),
                                                  empty: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Icon(Icons.star_border,
                                                          size: 250,
                                                          color:
                                                              Colors.grey[350]),
                                                      Icon(Icons.star,
                                                          size: 120,
                                                          color:
                                                              Colors.grey[350]),
                                                    ],
                                                  ),
                                                ),
                                                itemSize: 30,
                                                onRatingUpdate: (rating) {},
                                              ),
                                              Spacer(),
                                              Text(DateFormat('dd/MM/yyyy HH:mm')
                                                        .format(DateTime.fromMillisecondsSinceEpoch(rws[i].date)))
                                            ],
                                          );
                                        })),
                              );
                            }),
                      ),
                      SizedBox(height: 80,)
                    ],
                  ),
                ),
              ),
        beginOffset: Offset(0.0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}

class ChartReview {
  final String salerName;
  final int? nbr;
  final double? average;
  final int? nbrComment;

  ChartReview(this.salerName, {this.nbr, this.average, this.nbrComment});
}

class DateTimeChartReview {
  final DateTime datetime;
  final int? nbr;
  final double? average;
  final int? nbrComment;

  DateTimeChartReview(this.datetime, {this.nbr, this.average, this.nbrComment});
}

class SalerReviewWithDateTime {
  final SalerReview salerReview;
  final DateTime datetime;

  SalerReviewWithDateTime(this.salerReview, this.datetime);
}
