import 'package:flutter/material.dart';
import 'pages/home_page.dart';

class PasswordChangedSuccessfully extends StatefulWidget {
  @override
  PasswordChangedSuccessfullyState createState() => PasswordChangedSuccessfullyState();
}

class PasswordChangedSuccessfullyState extends State<PasswordChangedSuccessfully> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("asset/image/success.png")
              )
            ),
          ),
          Text("Успешно!", style: TextStyle(
            fontSize: 35
          ),),
          Text("Вы успешно изменили наш пароль. Пожалуйста, используйте свой новый пароль для входа в систему", style: TextStyle(
            fontSize: 18,
          ),textAlign: TextAlign.center,),
          SizedBox(height: 70,),
          Center(
            child: InkWell(
              onTap: openHomePage,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    color: Color(0xfff96060)
                ),
                child: Text("Продолжить", style: TextStyle(
                    fontSize: 18,
                    color: Colors.white
                ),),
              ),
            ),
          ),
        ],
      ),
    );
  }
  void openHomePage()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
  }
}

