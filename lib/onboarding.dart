import 'package:flutter/material.dart';
import 'login_page.dart';

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

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: PageView(
                  controller: _pageController,
                  children: [
                    onBoardPage(
                        "onboard1",
                        "Добро пожаловать в S-Busy",
                        "Сэкономь своё время - используй С-Бизи"
                    ),
                    onBoardPage(
                        "onboard2",
                        "Проблема",
                        "Ежедневно самозанятые сталкиваются с множеством мелких задач и заполнением бумажной волокиты, которые приходится делать самому"
                    ),
                    onBoardPage(
                        "onboard3",
                        "Решение",
                        "Мы представляем сервис с возможностью автоматизации задач и анализа доходов и расходов, который возьм>т на себя часть работы самозанятых"
                    ),
                  ],
                  onPageChanged: (value)=>{setCurrentPage(value)},
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) => getIndicator(index)),
              )
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(top: 20),
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('asset/image/path1.png'),
                      fit: BoxFit.fill
                  )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: openLoginPage,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 100
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
                  SizedBox(height: 30,),
                  Text("Войти", style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );

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
        Container(
          height: MediaQuery.of(context).size.width / 2,
          width: MediaQuery.of(context).size.width / 2,
          padding: EdgeInsets.all(50),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('asset/image/$img.png')
              )
          ),
        ),
        SizedBox(height: 20),
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
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Text(description, style: TextStyle(
              fontSize: 16,
              color: Colors.grey
          ),textAlign: TextAlign.center,),
        )
      ],
    );

  setCurrentPage(int value) => currentPage = value;

  openLoginPage() => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage())
  );
}
