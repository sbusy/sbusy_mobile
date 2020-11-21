import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';

void main() => initializeDateFormatting().then((_) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  /// Необходим для скроллинга календаря по горизонтали
  CalendarController _calendarController;

  TextStyle dayStyle(FontWeight fontWeight) => TextStyle(
      color: Color(0xff38384c),
      fontWeight: fontWeight
  );

  final Map<DateTime, List> _holidays = {
    DateTime(2020, 1, 1): ['New Year\'s Day'],
    DateTime(2020, 1, 6): ['Epiphany'],
    DateTime(2020, 2, 14): ['Valentine\'s Day'],
    DateTime(2020, 4, 21): ['Easter Sunday'],
    DateTime(2020, 4, 22): ['Easter Monday'],
  };

  Map<DateTime, List> _events; /// Все задачи

  List _selectedEvents; /// Задачи одного дня

  AnimationController _animationController; /// Анимация возникновения

  String _selectedDayString = "Сегодня"; /// Текущий день

  List<String> months = [
    "Января",
    "Февраля",
    "Марта",
    "Апреля",
    "Мая",
    "Июня",
    "Июля",
    "Августа",
    "Сентября",
    "Октября",
    "Ноября",
    "Декабря"
  ];

  @override
  void initState() {
    super.initState();

    final _selectedDay = DateTime.now();

    _events = {
      _selectedDay.subtract(Duration(days: 30)): [
        'Event A0',
        'Event B0',
        'Event C0'
      ],
      _selectedDay.subtract(Duration(days: 27)): ['Event A1'],
      _selectedDay.subtract(Duration(days: 20)): [
        'Event A2',
        'Event B2',
        'Event C2',
        'Event D2'
      ],
      _selectedDay.subtract(Duration(days: 16)): ['Event A3', 'Event B3'],
      _selectedDay.subtract(Duration(days: 10)): [
        'Event A4',
        'Event B4',
        'Event C4'
      ],
      _selectedDay.subtract(Duration(days: 4)): [
        'Event A5',
        'Event B5',
        'Event C5'
      ],
      _selectedDay.subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
      _selectedDay: ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
      _selectedDay.add(Duration(days: 1)): [
        'Event A8',
        'Event B8',
        'Event C8',
        'Event D8'
      ],
      _selectedDay.add(Duration(days: 3)):
      Set.from(['Event A9', 'Event A9', 'Event B9']).toList(),
      _selectedDay.add(Duration(days: 7)): [
        'Event A10',
        'Event B10',
        'Event C10'
      ],
      _selectedDay.add(Duration(days: 11)): ['Event A11', 'Event B11'],
      _selectedDay.add(Duration(days: 17)): [
        'Event A12',
        'Event B12',
        'Event C12',
        'Event D12'
      ],
      _selectedDay.add(Duration(days: 22)): ['Event A13', 'Event B13'],
      _selectedDay.add(Duration(days: 26)): [
        'Event A14',
        'Event B14',
        'Event C14'
      ],
    };

    _selectedEvents = _events[_selectedDay] ?? [];

    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();

    _animationController.dispose();

    _calendarController.dispose();
  }

  void _onDaySelected(DateTime day, List events, List holidays) =>
      setState(() {
        _selectedEvents = events;
        if (day.day == DateTime.now().day)
          _selectedDayString = "Сегодня";
        else if (day.year == DateTime.now().year
            && day.month == DateTime.now().month
            && day.day == DateTime.now().day + 1)
          _selectedDayString = "Завтра";
        else if (day.year == DateTime.now().year
            && day.month == DateTime.now().month
            && day.day + 1 == DateTime.now().day)
          _selectedDayString = "Вчера";
        else _selectedDayString = "${day.day} ${months[day.month - 1]}";
      });

  Container taskList(
      String title,
      String description,
      IconData iconImg,
      Color iconColor) => Container(
    padding: EdgeInsets.only(top: 20),
    child: Row(
      children: [
        Icon(iconImg, color: iconColor, size: 30),
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              )),
              SizedBox(height: 10),
              Text(description, style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.normal
              ))
            ],
          ),
        )
      ],
    ),
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: SingleChildScrollView(
                child: Column(
                    children: [
                      SizedBox(height: 30),

                      /// Виджет календаря
                      calendar(),

                      SizedBox(height: 20),

                      /// Виджет заданий
                      task()
                    ]
                )
            )
        )
    );
  }

  TableCalendar calendar() =>
      TableCalendar(
        locale: 'ru_RU',
        events: _events,
        holidays: _holidays,
        onDaySelected: _onDaySelected,
        calendarController: _calendarController,
        startingDayOfWeek: StartingDayOfWeek.monday,
        calendarStyle: CalendarStyle(
          weekdayStyle: dayStyle(FontWeight.normal),
          weekendStyle: dayStyle(FontWeight.normal),
          selectedColor: Color(0xff30374b),
          todayColor: Color(0xff30374b),
          markersColor: Colors.brown[700],
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(
                color: Color(0xff30384c),
                fontWeight: FontWeight.bold,
                fontSize: 16
            ),
            weekendStyle: TextStyle(
                color: Color(0xff30384c),
                fontWeight: FontWeight.bold,
                fontSize: 16
            ),
            dowTextBuilder: (date, locale) =>
                DateFormat.E(locale).format(date).substring(0, 1)
        ),
        headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleTextStyle: TextStyle(
                color: Color(0xff30384c),
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
            leftChevronIcon: Icon(
                Icons.chevron_left,
                color: Color(0xff30384c)
            ),
            rightChevronIcon: Icon(
                Icons.chevron_right,
                color: Color(0xff30384c)
            )
        ),
        builders: CalendarBuilders(

          /// Виджет маркера
          markersBuilder: (context, date, events, holidays) {
            final children = <Widget>[];

            if (events.isNotEmpty) {
              children.add(
                Positioned(
                  right: 1,
                  bottom: 1,
                  child: _buildEventsMarker(date, events),
                ),
              );
            }

            if (holidays.isNotEmpty) {
              children.add(
                Positioned(
                  right: -2,
                  top: -2,
                  child: _buildHolidaysMarker(),
                ),
              );
            }

            return children;
          },

        )
      );

  Container task() =>
      Container(
          padding: EdgeInsets.only(left: 30),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50)
              ),
              color: Color(0xff30384c)
          ),
          child: Stack(
              children: [
                /// Контент заданий
                taskBody(),

                /// Градиент заданий
                taskGradient(),

                /// Кнопка "Добавить задачу"
                taskButton()
              ]
          )
      );

  Column taskBody() =>
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(top: 50),
                child: Text(_selectedDayString, style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ))
            ),
            Column(
              children: _selectedEvents.map((event) => taskList(
                  "Задача ${_selectedEvents.indexOf(event) + 1}",
                  event.toString(),
                  CupertinoIcons.check_mark_circled_solid,
                  Color(0xff00cf8d)
              )).toList(),
            )
          ]
      );

  Positioned taskGradient() =>
      Positioned(
          bottom: 0,
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        Color(0xff30384c).withOpacity(0),
                        Color(0xff30384c)
                      ],
                      stops: [0.0, 1.0]
                  )
              )
          )
      );

  Positioned taskButton() =>
      Positioned(
          bottom: 40,
          right: 20,
          child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(20)
                  ),
                  color: Color(0xffb038f1),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black38,
                        blurRadius: 30
                    )
                  ]
              ),
              child: Text("+", style: TextStyle(
                  color: Colors.white,
                  fontSize: 40
              ))
          )
      );

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(50),
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date)
            ? Colors.brown[300]
            : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }
}