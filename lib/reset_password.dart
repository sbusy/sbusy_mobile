import 'package:flutter/material.dart';
import 'password_changed_successfully.dart';

class ResetPassword extends StatefulWidget {
  @override
  ResetPasswordState createState() => ResetPasswordState();
}

class ResetPasswordState extends State<ResetPassword> {
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
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Text("Сброс пароля", style: TextStyle(
                fontSize: 35
            ),),
            Text("Код сброса был отправлен на ваш почтовый идентификатор. Пожалуйста, введите код и создайте новый пароль", style: TextStyle(
                fontSize: 18,
                color: Colors.grey
            ),),
            SizedBox(height: 20,),
            Text("Код сброса", style: TextStyle(
              fontSize: 23,
            ),),
            TextField(
              decoration: InputDecoration(
                  hintText: "****"
              ),
              style: TextStyle(
                  fontSize: 20
              ),
            ),
            SizedBox(height: 40,),
            Text("Пароль", style: TextStyle(
              fontSize: 23,
            ),),
            TextField(
              decoration: InputDecoration(
                  hintText: "Введите свой пароль здесь"
              ),
              style: TextStyle(
                  fontSize: 20
              ),
            ),
            SizedBox(height: 40,),
            Text("Подтверждение пароля", style: TextStyle(
              fontSize: 23,
            ),),
            TextField(
              decoration: InputDecoration(
                  hintText: "Повторно введите свой пароль здесь"
              ),
              style: TextStyle(
                  fontSize: 20
              ),
            ),
            Expanded(
              child: Center(
                child: InkWell(
                  onTap: openSuccessPage,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        color: Color(0xfff96060)
                    ),
                    child: Text("Сменить пароль", style: TextStyle(
                        fontSize: 18,
                        color: Colors.white
                    ),),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  void openSuccessPage()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>PasswordChangedSuccessfully()));
  }
}

