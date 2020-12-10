import 'package:flutter/material.dart';
import '../home_page.dart';
import '../../widgets/wave_widget.dart';

class NewTask extends StatefulWidget {
  @override
  NewTaskState createState() => NewTaskState();
}

class NewTaskState extends State<NewTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xfff96060),
        elevation: 0,
        title: Text("Новая задача", style: TextStyle(
          fontSize: 25
        ),),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [

            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(7)),
                color: Colors.white
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.85,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 25,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Для", style: TextStyle(
                          fontSize: 18
                        ),),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.grey.withOpacity(0.2)
                          ),
                          child: Text("Стажёр", style: TextStyle(
                            fontSize: 18
                          ),),
                        ),
                        SizedBox(width: 10,),
                        Text("В", style: TextStyle(
                            fontSize: 18
                        ),),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: Colors.grey.withOpacity(0.2)
                          ),
                          child: Text("Проекте", style: TextStyle(
                              fontSize: 18
                          ),),
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.grey.withOpacity(0.2),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Заголовок",
                          border: InputBorder.none
                        ),
                        style: TextStyle(
                          fontSize: 18
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Описание", style: TextStyle(
                            fontSize: 18
                          ),),
                          SizedBox(height: 10,),
                          Container(
                          height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5)
                              )
                            ),
                            child: TextField(
                              maxLines: 6,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Добавьте сюда описание",
                              ),
                              style: TextStyle(
                                fontSize: 18
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5)
                              )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: IconButton(
                                    icon: Icon(Icons.attach_file, color:  Colors.grey,),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
                          Container(
                            padding: EdgeInsets.all(10),
                            color: Colors.grey.withOpacity(0.2),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Дедлайн",
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                fontSize: 18
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Добавить участника", style: TextStyle(
                            fontSize: 18
                          ),),
                          SizedBox(height: 20,),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: Colors.grey.withOpacity(0.2)
                            ),
                            child: Text("Все", style: TextStyle(
                              fontSize: 18
                            ),),
                          ),
                          SizedBox(height: 20,),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  color: Color(0xffff96060)
                              ),
                              child: Center(
                                child: Text("Добавить задачу", style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18
                                ),),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
