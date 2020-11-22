import 'package:flutter/material.dart';
import 'reset_password.dart';

class ForgotPassword extends StatefulWidget {
  @override
  ForgotPasswordState createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
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
            Text("Забыли пароль?", style: TextStyle(
                fontSize: 35
            ),),
            Text("Пожалуйста, введите свой идентификатор электронной почты, чтобы получить пароль и информацию о сбросе", style: TextStyle(
                fontSize: 18,
                color: Colors.grey
            ),),
            SizedBox(height: 20,),
            Text("E-Mail", style: TextStyle(
              fontSize: 23,
            ),),
            TextField(
              decoration: InputDecoration(
                  hintText: "john@example.com"
              ),
              style: TextStyle(
                  fontSize: 20
              ),
            ),
            SizedBox(height: 40,),
            Center(
              child: InkWell(
                onTap: openResetPassword,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      color: Color(0xfff96060)
                  ),
                  child: Text("Отправить запрос", style: TextStyle(
                      fontSize: 18,
                      color: Colors.white
                  ),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  void openResetPassword()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPassword()));
  }
}

