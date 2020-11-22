import 'package:flutter/material.dart';
import 'forgot_password.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Text("Добро пожаловать", style: TextStyle(
              fontSize: 35
            )),
            Text("Зарегистрируйтесь, чтобы продолжить", style: TextStyle(
                fontSize: 18,
              color: Colors.grey
            ),),
            SizedBox(height: 20,),
            Text("Имя", style: TextStyle(
                fontSize: 23,
            )),
            TextField(
              decoration: InputDecoration(
                hintText: "Ирина Смирнова"
              ),
              style: TextStyle(
                fontSize: 20
              ),
            ),
            SizedBox(height: 40,),
            Text("Пароль", style: TextStyle(
              fontSize: 23,
            )),
            TextField(
              decoration: InputDecoration(
                  hintText: "Введите сюда ваш пароль"
              ),
              style: TextStyle(
                  fontSize: 20
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: openForgotPassword,
                  child: Text("Забыли пароль?", style: TextStyle(
                    fontSize: 16
                  ),),
                )
              ],
            ),
            Expanded(
              child: Center(
                child: GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage())),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        color: Color(0xfff96060)
                    ),
                    child: Text("Зарегистрироваться", style: TextStyle(
                        fontSize: 18,
                        color: Colors.white
                    )),
                  ),
                )
              ),
            )
          ],
        ),
      ),
    );
  }
  void openForgotPassword()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword()));
  }
}
