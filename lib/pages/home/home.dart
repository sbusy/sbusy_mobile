import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:sbusy_mobile/widgets/smart_flare_animation.dart';
import 'calendar.dart';
import 'chat.dart';
import '../../widgets/wave_widget.dart';
import '../../pages/create/new_note.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  PageController _controller = PageController(initialPage: 0);

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  @override
  void initState() {
    super.initState();
  }

  List<IconData> icons = [
    Icons.home,
    Icons.analytics,
    Icons.analytics_outlined,
    Icons.home
  ];

  List<String> titles = [
    "Внешний вид",
    "Уведомления",
    "Аккаунт",
    "Подписка"
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
          body: Stack(
            children: [
              Container(
                height: size.height - 100,
                color: Color.fromARGB(255, 102, 18, 222),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeOutQuad,
                top: 0.0,
                child: WaveWidget(
                    size: size,
                    yOffset: size.height / 5.0,
                    color: Colors.white
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top:50,bottom: 70,left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            child: CircleAvatar(
                            ),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Ирина Смирнова',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                              Text('Актив',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))
                            ],
                          )
                        ],
                      ),
                      Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.palette,
                                    color: Color.fromARGB(255, 102, 18, 222),
                                    size: 30
                                  ),
                                  SizedBox(width: 10,),
                                  Text(
                                      "Вид",
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 102, 18, 222),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20
                                      )
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.notifications,
                                    color: Color.fromARGB(255, 102, 18, 222),
                                    size: 30
                                  ),
                                  SizedBox(width: 10,),
                                  Text(
                                      "Уведомления",
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 102, 18, 222),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20
                                      )
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: Color.fromARGB(255, 102, 18, 222),
                                    size: 30
                                  ),
                                  SizedBox(width: 10,),
                                  Text(
                                      "Аккаунт",
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 102, 18, 222),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20
                                      )
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.money,
                                    color: Color.fromARGB(255, 102, 18, 222),
                                    size: 30
                                  ),
                                  SizedBox(width: 10,),
                                  Text(
                                      "Подписки",
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 102, 18, 222),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20
                                      )
                                  )
                                ],
                              ),
                            )
                          ]
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.settings,
                            color: Color.fromARGB(255, 102, 18, 222),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Настройки',
                            style: TextStyle(
                                color: Color.fromARGB(255, 102, 18, 222),
                                fontWeight: FontWeight.bold
                            )
                          ),
                          SizedBox(width: 10,),
                          Container(
                            width: 2,
                            height: 20,
                            color: Color.fromARGB(255, 102, 18, 222),
                          ),
                          SizedBox(width: 10,),
                          Text(
                            'Выйти',
                            style:TextStyle(
                                color: Color.fromARGB(255, 102, 18, 222),
                                fontWeight: FontWeight.bold
                            )
                          )
                        ],
                      )
                    ],
                  ),
              ),
              GestureDetector(
                onTap: () => setState(() {
                  xOffset = 0;
                  yOffset = 0;
                  scaleFactor = 1;
                  isDrawerOpen = false;
                }),
                child: AnimatedContainer(
                    transform: Matrix4.translationValues(xOffset, yOffset, 0)
                      ..scale(scaleFactor)..rotateY(isDrawerOpen? -0.5:0),
                    duration: Duration(milliseconds: 250),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0)
                    ),
                    child: PageView(
                      controller: _controller,
                      children: [
                        Scaffold(
                            appBar: calendarAppBar(context),
                            body: Calendar(),
                          floatingActionButton: FloatingActionButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => NewNote())
                            ),
                            backgroundColor: Color.fromARGB(255, 102, 18, 222),
                            child: Icon(Icons.add),
                          ),
                        ),
                        Scaffold(
                            appBar: chatAppBar(context),
                            body: Chat()
                        )
                      ],
                    )
                ),
              )
            ],
          )
      ),
    );
  }

  AppBar calendarAppBar(BuildContext context) => AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: isDrawerOpen
        ? Icon(Icons.menu, color: Colors.black)
        : GestureDetector(
      onTap: () => setState(() {
        xOffset = 230;
        yOffset = 150;
        scaleFactor = 0.6;
        isDrawerOpen = true;
      }),
      child: Icon(Icons.menu, color: Colors.black),
    ),
    actions: [
      GestureDetector(
        onTap: () =>  _controller.nextPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.ease
        ),
        child: Icon(Icons.chat_rounded, color: Colors.black),
      ),
      SizedBox(width: 15)
    ],
  );

  AppBar chatAppBar(BuildContext context) => AppBar(
    elevation: 0,
    automaticallyImplyLeading: false,
    backgroundColor: Colors.white,
    flexibleSpace: SafeArea(
      child: Container(
        padding: EdgeInsets.only(right: 16),
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () => _controller.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.ease
              ),
              icon: Icon(Icons.arrow_back,color: Colors.black),
            ),
            SizedBox(width: 2),
            CircleAvatar(
              backgroundImage: AssetImage("asset/image/robert.jpeg"),
              maxRadius: 20,
            ),
            SizedBox(width: 12,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Роберт",style: TextStyle(fontWeight: FontWeight.w600)),
                  SizedBox(height: 6),
                  Text("Онлайн",style: TextStyle(color: Colors.green,fontSize: 12)),
                ]
              )
            ),
            Icon(Icons.more_vert,color: Colors.grey.shade700),
          ]
        )
      )
    )
  );
}