import 'dart:io';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:diademe/Bloc/Database/database_bloc.dart';
import 'package:diademe/Bloc/Database/database_state.dart';
import 'package:diademe/Models/Saler.dart';
import 'package:diademe/Models/SalerReview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import "package:collection/collection.dart";
import 'package:charts_flutter/flutter.dart' as charts;

class Statistics extends StatefulWidget {
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  late LoadedDatabaseState _databaseState;

  List<Saler> _salers = [];
  List<Saler?> _selectedSalers = [];
  bool isLoading = true;

  List<SalerReview> _salersReviews = [];

  Map<int, List<SalerReview>> _salersReviewsMap = {};

  DateTime? _selectedDate;
  DateTime _firstDate = DateTime(2020);
  DateTime _lastDate = DateTime.now().add(Duration(days: 1));

  DatePeriod? _selectedPeriodWeek;

  DatePeriod? _selectedPeriodRange;

   dynamic _date;
  dynamic _controller;
  PickerDateRange? _range;



  List<charts.Series<dynamic, String>> seriesList = [];
  

  late ButtonStyle style;

  @override
  void initState() {
    _databaseState =
        BlocProvider.of<DatabaseBloc>(context).state as LoadedDatabaseState;
    fetchSalers();
    fetchSalersReviews();
    super.initState();
  }

  Future<void> fetchSalers() async {
    _salers = await _databaseState.salerDao.findAllActifSalers();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchSalersReviews() async {
    _salersReviews = await _databaseState.salerReviewDao.findAllSalerReviews();
    setState(() {
      _salersReviewsMap = groupBy(_salersReviews, (SalerReview review) => review.salerId);

      List<ChartReview> reviewsNbr = [
        
      ];

      List<ChartReview> averageReview = [
        
      ];

      _salersReviewsMap.forEach((key, value) {
        reviewsNbr.add(ChartReview(_salers.firstWhere((element) => element.id == key).name, nbr: value.length));
        var sum = value.map((sr) => sr.mark).reduce((value, element) => value+element);
        averageReview.add(ChartReview(_salers.firstWhere((element) => element.id == key).name, average: double.parse((sum / value.length).toStringAsFixed(2)) ));
       });

       seriesList.add(new charts.Series<ChartReview, String>(
        id: 'Nombre de notes',
        domainFn: (ChartReview rvws, _) => rvws.salerName,
        measureFn: (ChartReview rvws, _) => rvws.nbr!,
        data: reviewsNbr,
      ),);

      seriesList.add(new charts.Series<ChartReview, String>(
        id: 'Note moyenne',
        domainFn: (ChartReview rvws, _) => rvws.salerName,
        measureFn: (ChartReview rvws, _) => rvws.average!,
        data: averageReview,
      ),);


      isLoading = false;
    });
  }

  void _onSelectedDateChangedWeek(DatePeriod newPeriod) {
    setState(() {
      _selectedPeriodWeek = newPeriod;
      _selectedDate = null;
      _selectedPeriodRange = null;
    });
    Navigator.pop(context);
  }

  bool _isSelectableCustomWeek(DateTime day) {
//    return day.weekday < 6;
    return day.day != DateTime.now().add(Duration(days: 7)).day;
  }

  void _onSelectedDateChangedMonth(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
      _selectedPeriodWeek = null;
      _selectedPeriodRange = null;
    });
    Navigator.pop(context);
  }

  // void _onSelectedDateChangedRange(DatePeriod newPeriod) {
  //   setState(() {
  //     _selectedPeriodRange = newPeriod;
  //     _selectedDate = null;
  //     _selectedPeriodWeek = null;
  //   });
  //   Navigator.pop(context);
  //   //showRangedatePicker();
  // }



  String _dayHeaderTitleBuilder(
          int dayOfTheWeek, List<String> localizedHeaders) =>
      localizedHeaders[dayOfTheWeek].substring(0, 3);

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
        title: Text('Statistiques'),
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
              child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: MultiSelectChipField<Saler?>(
                        height: 130,
                        items: _salers
                            .map((saler) =>
                                MultiSelectItem<Saler?>(saler, saler.name))
                            .toList(),
                        itemBuilder: (item, state) {
                          // return your custom widget here
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                _selectedSalers.contains(item.value)
                                    ? _selectedSalers.remove(item.value)
                                    : _selectedSalers.add(item.value);
                                state.didChange(_selectedSalers);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Container(
                                        width: 75,
                                        child: AspectRatio(
                                          aspectRatio: 1,
                                          child: Container(
                                            child: Card(
                                              elevation: 1.0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(300),
                                                  side: BorderSide(
                                                      width: 1,
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(300),
                                                child: Image.file(
                                                  File(_databaseState.path +
                                                      '/' +
                                                      item.value!.image),
                                                  fit: BoxFit.fill,
                                                  alignment: Alignment.center,
                                                ),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.white54,
                                                  blurRadius: 5.0,
                                                  offset: Offset(0, 15),
                                                  spreadRadius: 0.5,
                                                ),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(300),
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (_selectedSalers.contains(item.value))
                                        Container(
                                          height: 73,
                                          width: 73,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .primaryColor
                                                .withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(300),
                                          ),
                                        )
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 80,
                                    child: Text(item.value!.name, style: Theme.of(context).textTheme.bodyText1, textAlign: TextAlign.center)
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Expanded(
                    //   child: MultiSelectDialogField(
                    //     searchable: true,
                    //     items: _salers
                    //         .map(
                    //             (saler) => MultiSelectItem<Saler?>(saler, saler.name))
                    //         .toList(),
                    //     title: Text("Vendeurs"),
                    //     selectedColor: Theme.of(context).primaryColor,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.all(Radius.circular(5)),
                    //       border: Border.all(
                    //         color: Theme.of(context).primaryColor,
                    //         width: 2,
                    //       ),
                    //     ),
                    //     buttonIcon: Icon(
                    //       Icons.people,
                    //       color: Theme.of(context).primaryColor,
                    //     ),
                    //     buttonText: Text(
                    //       "Liste des vendeurs",
                    //       style: TextStyle(
                    //         fontSize: 16,
                    //       ),
                    //     ),
                    //     onConfirm: (results) {
                    //       _selectedSalers = results as List<Saler?>;
                    //     },
                    //   ),
                    // ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElevatedButton(
                              style: style,
                              onPressed: () {
                                showRangedatePicker();
                                // showDateRangePicker(
                                //   context: context,
                                //   firstDate: _firstDate,
                                //   lastDate: _lastDate,
                                //   locale: Locale('pt', 'BR')
                                // );

                              },
                              child: Text(_range != null
                                  ? DateFormat.yMMMd('fr_FR')
                                          .format(_range!.startDate!) +
                                      ' - ' +
                                      DateFormat.yMMMd('fr_FR')
                                          .format(_range!.endDate!)
                                  : "Personnalisé")),



                          Container(
                            width: 500,
                            height: 500,
                            child: charts.BarChart(
                              seriesList,
                              animate: true,
                              barGroupingType: charts.BarGroupingType.grouped,
                              behaviors: [new charts.SeriesLegend()],
                            ),
                          ),



                        ],
                      ),
                    ),
                  ],
                ),
            ),
        beginOffset: Offset(0.0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }

  void showRangedatePicker() {
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => SimpleDialog(
          insetPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              children: [
                Container(
                  width: 450,
                  child: SfDateRangePicker(
                    minDate: _firstDate,
                    maxDate: _lastDate,
                    showTodayButton: true,
                    showActionButtons: true,
                    selectionMode: DateRangePickerSelectionMode.range,
                    confirmText: "Confirmer",
                    cancelText: "Annuler",
                    initialSelectedRange: _range,
                    onSubmit: (Object? value){
                      PickerDateRange? _r = value != null ? value as PickerDateRange : PickerDateRange(null,null);
                      if(_r.startDate != null && _r.endDate != null) {
                      setState(() {
                        _range = _r;
                      });
                      Navigator.pop(context);
                      }
                    },
                    onCancel: () {
                      // setState(() {
                      //   _range = null;
                      // });
                      Navigator.pop(context);
                    },
                  ))
                //FittedBox(
                  // child: RangePicker(
                  //   selectedPeriod: _selectedPeriodRange ??
                  //       DatePeriod(DateTime.now(), DateTime.now()),
                  //   onChanged: _onSelectedDateChangedRange,
                  //   firstDate: _firstDate,
                  //   lastDate: _lastDate,
                  //   datePickerStyles: styles,
                  // ),
                //),
              ],
            ));
  }
}


class ChartReview {
  final String salerName;
  final int? nbr;
  final double? average;

  ChartReview(this.salerName, {this.nbr, this.average});
}