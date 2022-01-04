import 'dart:io';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:diademe/Bloc/Database/database_bloc.dart';
import 'package:diademe/Bloc/Database/database_state.dart';
import 'package:diademe/Models/Saler.dart';
import 'package:diademe/Models/SalerReview.dart';
import 'package:diademe/pages/chart.dart';
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

  DateTime _firstDate = DateTime(2020);
  DateTime _lastDate = DateTime.now().add(Duration(days: 1));

  PickerDateRange? _range;

  List<charts.Series<dynamic, String>> seriesList = [];

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
    setState(() {
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
        title: Text('Statistiques'),
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      MultiSelectChipField<Saler?>(
                        showHeader: false,
                        height: 140,
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
                                        width: 90,
                                        child: AspectRatio(
                                          aspectRatio: 1,
                                          child: Container(
                                            child: Card(
                                              elevation: 1.0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          300),
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
                                          height: 87,
                                          width: 87,
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
                                      child: Text(item.value!.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                          textAlign: TextAlign.center))
                                ],
                              ),
                            ),
                          );
                        },
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

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElevatedButton(
                              style: style,
                              onPressed: () {
                                showRangedatePicker();
                              },
                              child: Text(_range != null
                                  ? DateFormat.yMMMd('fr_FR')
                                          .format(_range!.startDate!) +
                                      ' - ' +
                                      DateFormat.yMMMd('fr_FR')
                                          .format(_range!.endDate!)
                                  : "Personnalisé")),
                          ElevatedButton(
                              style: style,
                              onPressed: () {
                                if (_range != null &&
                                    _selectedSalers.isNotEmpty) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Chart(
                                              selectedSalers: _selectedSalers,
                                              range: _range!,
                                              isGlobal: true,)));
                                }
                              },
                              child: Text("Recherche globale")),

                              ElevatedButton(
                              style: style,
                              onPressed: () {
                                if (_range != null &&
                                    _selectedSalers.isNotEmpty) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Chart(
                                              selectedSalers: _selectedSalers,
                                              range: _range!,
                                              isGlobal: false,)));
                                }
                              },
                              child: Text("Recherche detaillé")),
                        ],
                      ),
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
                      onSubmit: (Object? value) {
                        PickerDateRange? _r = value != null
                            ? value as PickerDateRange
                            : PickerDateRange(null, null);
                        if (_r.startDate != null && _r.endDate != null) {
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
