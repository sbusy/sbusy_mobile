import 'package:flutter/material.dart';
import '../home_page.dart';
import '../../widgets/wave_widget.dart';

class CheckList extends StatefulWidget {
  @override
  CheckListState createState() => CheckListState();
}

class CheckListState extends State<CheckList> {
  bool checked = false;
  List<int> selectedList = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xfff96060),
          elevation: 0,
          title: Text("Новый чеклист", style: TextStyle(
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
                height: size.height - 200,
                color: Color.fromARGB(255, 102, 18, 222),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeOutQuad,
                top: 0.0,
                child: WaveWidget(
                    size: size,
                    yOffset: size.height / 3.0,
                    color: Colors.white
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    color: Colors.white
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.85,
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Заголовок", style: TextStyle(
                                  fontSize: 18
                              ),),
                              SizedBox(height: 10,),
                              Text("Описание", style: TextStyle(
                                  fontSize: 18
                              ),),

                              SizedBox(height: 20,),
                              CheckboxListTile(
                                title: Text("Лист 1",),
                                controlAffinity: ListTileControlAffinity.leading,
                                onChanged: (bool value){
                                  setState(() {
                                    if(value){
                                      selectedList.add(1);
                                    }else{
                                      selectedList.remove(1);
                                    }
                                  });
                                },
                                value:selectedList.contains(1),
                              ),
                              CheckboxListTile(
                                title: Text("Лист 2",),
                                controlAffinity: ListTileControlAffinity.leading,
                                onChanged: (bool value){
                                  setState(() {
                                    if(value){
                                      selectedList.add(2);
                                    }else{
                                      selectedList.remove(2);
                                    }
                                  });
                                },
                                value:selectedList.contains(2),
                              ),
                              CheckboxListTile(
                                title: Text("Лист 3",),
                                controlAffinity: ListTileControlAffinity.leading,
                                onChanged: (bool value){
                                  setState(() {
                                    if(value){
                                      selectedList.add(3);
                                    }else{
                                      selectedList.remove(3);
                                    }
                                  });
                                },
                                value:selectedList.contains(3),
                              ),
                              Text("Цвет", style: TextStyle(
                                  fontSize: 18
                              ),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        color: Colors.pink
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        color: Colors.blue
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        color: Colors.green
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        color: Color(0xfff4ca8f)
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        color: Color(0xff3d3a62)
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 40,),
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                      color: Color(0xffff96060)
                                  ),
                                  child: Center(
                                    child: Text("Добавить чеклист", style: TextStyle(
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
