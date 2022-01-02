import 'dart:io';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:diademe/Bloc/Database/database_bloc.dart';
import 'package:diademe/Bloc/Database/database_state.dart';
import 'package:diademe/Models/Saler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;

class Statistics extends StatefulWidget {
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  late LoadedDatabaseState _databaseState;

  List<Saler> _salers = [];
  List<Saler?> _selectedSalers = [];
  bool isLoading = true;

  DateTime? _selectedDate;
  DateTime _firstDate = DateTime(2020);
  DateTime _lastDate = DateTime.now().add(Duration(days: 1));

  DatePeriod? _selectedPeriodWeek;

  DatePeriod? _selectedPeriodRange;

  @override
  void initState() {
    _databaseState =
        BlocProvider.of<DatabaseBloc>(context).state as LoadedDatabaseState;
    fetchSalers();
    super.initState();
  }

  Future<void> fetchSalers() async {
    _salers = await _databaseState.salerDao.findAllSalers();
    setState(() {
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

  void _onSelectedDateChangedRange(DatePeriod newPeriod) {
    setState(() {
      _selectedPeriodRange = newPeriod;
      _selectedDate = null;
      _selectedPeriodWeek = null;
    });
  }

  String _dayHeaderTitleBuilder(
          int dayOfTheWeek, List<String> localizedHeaders) =>
      localizedHeaders[dayOfTheWeek].substring(0, 3);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20),
        elevation: 15,
        primary: Theme.of(context).primaryColor.withOpacity(0.7),
        onPrimary: Colors.black);

    dp.DatePickerRangeStyles styles = dp.DatePickerRangeStyles(
      selectedDateStyle: Theme.of(context).accentTextTheme.bodyText1,
      selectedSingleDateDecoration: BoxDecoration(
          color: Theme.of(context).primaryColor, shape: BoxShape.circle),
      dayHeaderStyle: DayHeaderStyle(textStyle: TextStyle(color: Colors.red)),
      dayHeaderTitleBuilder: _dayHeaderTitleBuilder,
      selectedPeriodLastDecoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(10.0), bottomEnd: Radius.circular(10.0))),
      selectedPeriodStartDecoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(10.0),
            bottomStart: Radius.circular(10.0)),
      ),
      selectedPeriodMiddleDecoration: BoxDecoration(
          color: Theme.of(context).primaryColor, shape: BoxShape.rectangle),
    );
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
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child:
                  MultiSelectChipField<Saler?>(
                    height: 90,
                    items: _salers
                        .map((saler) =>
                            MultiSelectItem<Saler?>(saler, saler.name))
                        .toList(),
                    itemBuilder: (item, state) {
                      // return your custom widget here
                      return InkWell(
                        onTap: () {
                          _selectedSalers.contains(item.value)
                              ? _selectedSalers.remove(item.value)
                              : _selectedSalers.add(item.value);
                          state.didChange(_selectedSalers);
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: 70,
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
                                          borderRadius: BorderRadius.circular(300),
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
                                        borderRadius: BorderRadius.circular(300),
                                      ),
                                    ),
                                  ),
                                ),
                                if(_selectedSalers.contains(item.value))
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(300),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),),
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
                  SizedBox(width: 15),
                  ElevatedButton(
                      style: style,
                      onPressed: () {
                        showDialog<void>(
                            context: context,
                            builder: (BuildContext context) => SimpleDialog(
                                  title: const Text('Mensuelle'),
                                  children: [
                                    dp.MonthPicker.single(
                                      selectedDate:
                                          _selectedDate ?? DateTime.now(),
                                      onChanged: _onSelectedDateChangedMonth,
                                      firstDate: _firstDate,
                                      lastDate: _selectedDate != null &&
                                              _selectedDate!.isAfter(_lastDate)
                                          ? _selectedDate!
                                          : _lastDate,
                                      datePickerStyles: styles,
                                    ),
                                  ],
                                ));
                      },
                      child: Text(_selectedDate != null
                          ? DateFormat.yMMMM('fr_FR').format(_selectedDate!)
                          : "Mensuelle")),
                  SizedBox(width: 15),
                  ElevatedButton(
                      style: style,
                      onPressed: () {
                        showDialog<void>(
                            context: context,
                            builder: (BuildContext context) => SimpleDialog(
                                  title: const Text('Hebdomadaire'),
                                  children: [
                                    WeekPicker(
                                      selectedDate: _selectedPeriodWeek != null
                                          ? _selectedPeriodWeek!.start
                                          : DateTime.now(),
                                      onChanged: _onSelectedDateChangedWeek,
                                      firstDate: _firstDate,
                                      lastDate: _lastDate,
                                      datePickerStyles: styles,
                                      //selectableDayPredicate: _isSelectableCustomWeek,
                                    ),
                                  ],
                                ));
                      },
                      child: Text(_selectedPeriodWeek != null
                          ? DateFormat.yMMMd('fr_FR')
                                  .format(_selectedPeriodWeek!.start) +
                              ' - ' +
                              DateFormat.yMMMd('fr_FR')
                                  .format(_selectedPeriodWeek!.end)
                          : "Hebdomadaire")),
                  SizedBox(width: 15),
                  ElevatedButton(
                      style: style,
                      onPressed: () {
                        showDialog<void>(
                            context: context,
                            builder: (BuildContext context) => SimpleDialog(
                                  title: const Text('Personnalisé'),
                                  children: [
                                    RangePicker(
                                      selectedPeriod: _selectedPeriodRange ??
                                          DatePeriod(
                                              DateTime.now(), DateTime.now()),
                                      onChanged: _onSelectedDateChangedRange,
                                      firstDate: _firstDate,
                                      lastDate: _lastDate,
                                      datePickerStyles: styles,
                                    ),
                                  ],
                                ));
                      },
                      child: Text(_selectedPeriodRange != null
                          ? DateFormat.yMMMd('fr_FR')
                                  .format(_selectedPeriodRange!.start) +
                              ' - ' +
                              DateFormat.yMMMd('fr_FR')
                                  .format(_selectedPeriodRange!.end)
                          : "Personnalisé")),
                ],
              ),
            ),
          ],
        ),
        beginOffset: Offset(0.0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
