import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
void main() {
  runApp(MyApp());
}

///
class MyApp extends StatelessWidget {
  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: [
        const Locale('en', 'US'), // American English
        const Locale('ru', 'RU'), // Russian
        const Locale("pt"), // Portuguese
        const Locale('ar'), // Arabic
      ],
      debugShowCheckedModeBanner: false,
      title: 'Date pickers demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(
        title: 'flutter_date_pickers Demo',
      ),
    );
  }
}

/// Start page.
class MyHomePage extends StatefulWidget {
  /// Page title.
  final String title;

  ///
  MyHomePage({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  DateTime startOfPeriod = DateTime.now().subtract(Duration(days: 10));
  DateTime endOfPeriod = DateTime.now().add(Duration(days: 10));
  int _selectedTab = 0;

  List<DateTime> _selectedDates = [DateTime.now()];
  DateTime _selectedDate = DateTime.now();

  DateTime _firstDate = DateTime.now().subtract(Duration(days: 45));
  DateTime _lastDate = DateTime.now().add(Duration(days: 45));

  Color selectedDateStyleColor = Colors.blue;
  Color selectedSingleDateDecorationColor = Colors.red;

  DatePeriod _selectedPeriod = DatePeriod(
      DateTime.now().add(Duration(days: 2)),
      DateTime.now().subtract(Duration(days: 1)));

  DatePeriod _selectedPeriodRange = DatePeriod(
      DateTime.now().subtract(Duration(days: 30)),
      DateTime.now().subtract(Duration(days: 12)));

  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    dp.DatePickerRangeStyles styles = dp.DatePickerRangeStyles(
        selectedDateStyle: Theme.of(context)
            .accentTextTheme
            .bodyText1
            ?.copyWith(color: selectedDateStyleColor),
        selectedSingleDateDecoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            shape: BoxShape.circle
        ),
        dayHeaderStyle: DayHeaderStyle(
            textStyle: TextStyle(
                color: Colors.red
            )
        ),
        dayHeaderTitleBuilder: _dayHeaderTitleBuilder
    );

    final List<Widget> datePickers = <Widget>[
    dp.DayPicker.single(
            selectedDate: _selectedDate,
            onChanged: _onSelectedDateChangedsingle,
            firstDate: _firstDate,
            lastDate: _lastDate,
            datePickerStyles: styles,
            datePickerLayoutSettings: dp.DatePickerLayoutSettings(
                //maxDayPickerRowCount: 2,
                showPrevMonthEnd: true,
                showNextMonthStart: true
            ),
            selectableDayPredicate: _isSelectableCustom,
          ),
    dp.DayPicker.multi(
            selectedDates: _selectedDates,
            onChanged: _onSelectedDateChanged,
            firstDate: _firstDate,
            lastDate: _lastDate,
            datePickerStyles: styles,
            datePickerLayoutSettings: dp.DatePickerLayoutSettings(
                //maxDayPickerRowCount: 2,
                showPrevMonthEnd: true,
                showNextMonthStart: true
            ),
            selectableDayPredicate: _isSelectableCustom,
          ),
    WeekPicker(
            selectedDate: _selectedDate,
            onChanged: _onSelectedDateChangedWeek,
            firstDate: _firstDate,
            lastDate: _lastDate,
            datePickerStyles: styles,
            onSelectionError: _onSelectionError,
            selectableDayPredicate: _isSelectableCustomWeek,
          ),
    RangePicker(
            initiallyShowDate: DateTime.now(),
            selectedPeriod: _selectedPeriodRange,
            onChanged: _onSelectedDateChangedRange,
            firstDate: _firstDate,
            lastDate: _lastDate,
            datePickerStyles: styles,
            selectableDayPredicate: _isSelectableCustomRange,
            onSelectionError: _onSelectionError,
          ),
    dp.MonthPicker.single(
            selectedDate: _selectedDate,
            onChanged: _onSelectedDateChangedMonth,
            firstDate: _firstDate,
            lastDate: _lastDate,
            datePickerStyles: styles,
          ),
    dp.MonthPicker.multi(
            selectedDates: _selectedDates,
            onChanged: _onSelectedDateChanged,
            firstDate: _firstDate,
            lastDate: _lastDate,
            datePickerStyles: styles,
          ),
  ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(letterSpacing: 1.15),
        ),
      ),
      body: datePickers[_selectedTab],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Colors.blueGrey,
            textTheme: Theme.of(context).textTheme.copyWith(
                caption: TextStyle(color: Colors.white.withOpacity(0.5)))),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.date_range), label: "Day"),
            BottomNavigationBarItem(
                icon: Icon(Icons.date_range), label: "Days"),
            BottomNavigationBarItem(
                icon: Icon(Icons.date_range), label: "Week"),
            BottomNavigationBarItem(
                icon: Icon(Icons.date_range), label: "Range"),
            BottomNavigationBarItem(
                icon: Icon(Icons.date_range), label: "Month"),
            BottomNavigationBarItem(
                icon: Icon(Icons.date_range), label: "Months"),
          ],
          fixedColor: Colors.yellow,
          currentIndex: _selectedTab,
          onTap: (newIndex) {
            setState(() {
              _selectedTab = newIndex;
            });
          },
        ),
      ),
    );
  }

  bool _isSelectableCustom (DateTime day) {
    return day.weekday < 6;
  }

  bool _isSelectableCustomRange(DateTime day) {
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(Duration(days: 1));
    DateTime tomorrow = now.add(Duration(days: 1));
    bool isYesterday = sameDate(day, yesterday);
    bool isTomorrow = sameDate(day, tomorrow);

    return !isYesterday && !isTomorrow;

    // return true;
//    return day.weekday < 6;
//    return day.day != DateTime.now().add(Duration(days: 7)).day ;
  }
  
bool sameDate(DateTime first, DateTime second) {
  return first.year == second.year &&
      first.month == second.month &&
      first.day == second.day;
}

  void _onSelectedDateChangedsingle(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
    });
  }

  void _onSelectedDateChanged(List<DateTime> newDates) {
    setState(() {
      _selectedDates = newDates;
    });
  }

  void _onSelectedDateChangedWeek(DatePeriod newPeriod) {
    setState(() {
      _selectedDate = newPeriod.start;
      _selectedPeriod = newPeriod;
    });
  }

  void _onSelectedDateChangedRange(DatePeriod newPeriod) {
    setState(() {
      _selectedPeriodRange = newPeriod;
    });
  }

  void _onSelectedDateChangedMonth(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
    });
  }

  bool _isSelectableCustomWeek(DateTime day) {
//    return day.weekday < 6;
    return day.day != DateTime.now().add(Duration(days: 7)).day;
  }

  void _onSelectionError(Object e) {
    if (e is UnselectablePeriodException) print("catch error: $e");
  }

  String _dayHeaderTitleBuilder(int dayOfTheWeek, List<String> localizedHeaders)
  => localizedHeaders[dayOfTheWeek].substring(0,3);

}