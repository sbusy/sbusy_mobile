import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'login_or_signup/signup.dart';
import 'login_or_signup/login.dart';
import '../widgets/wave_widget.dart';
import '../widgets/fade_animation.dart';

class Onboarding extends StatefulWidget {
  @override
  OnboardingState createState() => OnboardingState();
}

class OnboardingState extends State<Onboarding>
    with SingleTickerProviderStateMixin{
  int currentPage = 0;

  PageController _pageController = new PageController(
      initialPage: 0,
      keepPage: true
  );

  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: 0.0,
      duration: Duration(seconds: 25),
      upperBound: 1,
      lowerBound: -1,
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Stack(
            children: [
              WaveWidget(
                size: size,
                yOffset: size.height / 1.4,
                color: Color.fromARGB(255, 102, 18, 222)
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: PageView(
                      controller: _pageController,
                      children: [
                        onBoardPage(
                            "onboarding",
                            "Добро пожаловать в S-Busy",
                            "Сэкономь своё время - используй С-Бизи"
                        ),
                        onBoardPage(
                            "problem",
                            "Проблема",
                            "Ежедневно самозанятые сталкиваются с множеством мелких задач и заполнением бумажной волокиты, которые приходится делать самому"
                        ),
                        onBoardPage(
                            "solution",
                            "Решение",
                            "Мы представляем сервис с возможностью автоматизации задач и анализа доходов и расходов, который возьм>т на себя часть работы самозанятых"
                        ),
                      ],
                      onPageChanged: (value)=>{setCurrentPage(value)},
                    ),
                  ),
                  FadeAnimation(
                      1,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (index) => getIndicator(index)),
                      )
                  )
                ],
              ),
              Positioned(
                bottom: 0,
                left: 20,
                right: 20,
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeAnimation(
                        1.25,
                        InkWell(
                          onTap: openLoginPage,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 20
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    offset: Offset(0,9),
                                    blurRadius: 20,
                                    spreadRadius: 3
                                )]
                            ),
                            child: Text("Зарегистрироваться", style: TextStyle(
                                fontSize: 16
                            )),
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                      FadeAnimation(
                        1.5,
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Login())
                            ),
                            child: Text("Войти", style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            )),
                          )
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );
  }

  AnimatedContainer getIndicator(int pageNo) => AnimatedContainer(
      duration: Duration(milliseconds: 100),
      height: 10,
      width: (currentPage == pageNo) ? 20 : 10,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: (currentPage == pageNo) ? Colors.black : Colors.grey
      ),
    );

  Column onBoardPage(String img, String title, description) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
        ),
        FadeAnimation(
          0.25,
          SvgPicture.asset(
              'asset/image/$img.svg',
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width
          ),
        ),
        SizedBox(height: 20),
        FadeAnimation(
          0.5,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                )
            ),
          ),
        ),
        FadeAnimation(
          0.75,
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text(description, style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey
              ),textAlign: TextAlign.center,),
            )
        )
      ],
    );

  setCurrentPage(int value) => setState(() => currentPage = value);

  openLoginPage() => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Signup())
  );
}
