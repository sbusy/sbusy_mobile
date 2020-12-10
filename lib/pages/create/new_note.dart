import 'package:flutter/material.dart';
import 'package:sbusy_mobile/widgets/smart_flare_animation.dart';
import '../home_page.dart';
import '../../widgets/wave_widget.dart';
import '../../widgets/fade_animation.dart';
import '../../widgets/textfield_widget.dart';
import '../../widgets/button_widget.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import '../../backend/singleton.dart';
import 'package:provider/provider.dart';

enum AnimationToPlay {
  Activate,
  Deactivate,
  CameraTapped,
  PulseTapped,
  ImageTapped
}

class NewNote extends StatefulWidget {
  @override
  NewNoteState createState() => NewNoteState();
}

class NewNoteState extends State<NewNote> with SingleTickerProviderStateMixin {
  AnimationController _scaleController;
  Animation<double> _scaleAnimation;

  TextEditingController _textEditingController = TextEditingController();

  bool hide = false;

  static const double AnimationWidth = 295.0;
  static const double AnimationHeight = 251.0;

  AnimationToPlay _lastPlayedAnimation;

  // Flare animation controls
  final FlareControls animationControls = FlareControls();

  bool isOpen = false;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300)
    );

    _scaleAnimation = Tween<double>(
        begin: 1.0,
        end: 30.0
    ).animate(_scaleController)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Provider.of<Singleton>(context, listen: false).selectedEvents.add(_textEditingController.text);
        Navigator.pop(context);
        Future.delayed(Duration(seconds: 1)).then((value) {
          _scaleController.reset();
          setState(() => hide = false);
        });
      }
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<Singleton>(builder: (context, task, child) {
      return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: GestureDetector(
                  child: Stack(
                    children: <Widget>[
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
                      SafeArea(
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Icon(Icons.arrow_back_ios, color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 100.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FadeAnimation(
                              0.25,
                              Text(
                                'Новая задача',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30, top: 222),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FadeAnimation(
                              0.5,
                              TextFieldWidget(
                                hintText: 'Заголовок',
                                obscureText: false,
                                prefixIconData: Icons.code,
                                // suffixIconData: model.isVisible
                                //     ? Icons.visibility
                                //     : Icons.visibility_off,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                FadeAnimation(
                                    0.75,
                                    TextField(
                                      // onChanged: onChanged,
                                      // obscureText: obscureText,
                                      cursorColor: Color.fromARGB(255, 102, 18, 222),
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 102, 18, 222),
                                        fontSize: 14.0,
                                      ),
                                      decoration: InputDecoration(
                                        labelStyle: TextStyle(color: Color.fromARGB(255, 102, 18, 222)),
                                        focusColor: Color.fromARGB(255, 102, 18, 222),
                                        filled: true,
                                        enabledBorder: UnderlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide.none,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(color: Color.fromARGB(255, 102, 18, 222)),
                                        ),
                                        labelText: "Описание",
                                      ),
                                      maxLines: 5,
                                      controller: _textEditingController,
                                    )
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                _images()
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            FadeAnimation(
                                1.25,
                                AnimatedBuilder(
                                    animation: _scaleController,
                                    builder: (context, child) =>
                                        Transform.scale(
                                          scale: _scaleAnimation.value,
                                          child: ButtonWidget(
                                              title: hide ? "" : 'Добавить',
                                              hasBorder: false,
                                              onPress: () {
                                                setState(() => hide = true);
                                                _scaleController.forward();
                                              }
                                          ),
                                        )
                                )
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            // body: Container(
            //   height: MediaQuery.of(context).size.height,
            //   child: Stack(
            //     children: [
            //       Container(
            //         height: 30,
            //         color: Color(0xfff96060),
            //       ),
            //       Positioned(
            //         bottom: 0,
            //         child: Container(
            //           height: 70,
            //           width: MediaQuery.of(context).size.width,
            //           color: Colors.black.withOpacity(0.8),
            //         ),
            //       ),
            //       Container(
            //         margin: EdgeInsets.symmetric(horizontal: 15),
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.all(Radius.circular(7)),
            //             color: Colors.white
            //         ),
            //         width: MediaQuery.of(context).size.width,
            //         height: MediaQuery.of(context).size.height * 0.85,
            //         child: SingleChildScrollView(
            //           child: Container(
            //             padding: EdgeInsets.all(20),
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //
            //                 Container(
            //                   padding: EdgeInsets.all(15),
            //                   child: Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       Text("Описание", style: TextStyle(
            //                           fontSize: 18
            //                       ),),
            //                       SizedBox(height: 10,),
            //                       Container(
            //                         height: 150,
            //                         width: double.infinity,
            //                         decoration: BoxDecoration(
            //                             color: Colors.white,
            //                             borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
            //                             border: Border.all(
            //                                 color: Colors.grey.withOpacity(0.5)
            //                             )
            //                         ),
            //                         child: TextField(
            //                           maxLines: 6,
            //                           decoration: InputDecoration(
            //                             border: InputBorder.none,
            //                             hintText: "Добавьте сюда описание",
            //                           ),
            //                           style: TextStyle(
            //                               fontSize: 18
            //                           ),
            //                         ),
            //                       ),
            //                       Container(
            //                         height: 50,
            //                         width: double.infinity,
            //                         decoration: BoxDecoration(
            //                             color: Colors.grey.withOpacity(0.2),
            //                             borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
            //                             border: Border.all(
            //                                 color: Colors.grey.withOpacity(0.5)
            //                             )
            //                         ),
            //                         child: Row(
            //                           mainAxisAlignment: MainAxisAlignment.start,
            //                           children: [
            //                             Container(
            //                               child: IconButton(
            //                                 icon: Icon(Icons.attach_file, color:  Colors.grey,),
            //                               ),
            //                             )
            //                           ],
            //                         ),
            //                       ),
            //                       SizedBox(height: 20,),
            //                       Text("Цвет", style: TextStyle(
            //                           fontSize: 18
            //                       ),),
            //                       Row(
            //                         mainAxisAlignment: MainAxisAlignment.spaceAround,
            //                         children: [
            //                           Container(
            //                             height: 50,
            //                             width: 50,
            //                             decoration: BoxDecoration(
            //                                 borderRadius: BorderRadius.all(Radius.circular(10)),
            //                                 color: Colors.pink
            //                             ),
            //                           ),
            //                           Container(
            //                             height: 50,
            //                             width: 50,
            //                             decoration: BoxDecoration(
            //                                 borderRadius: BorderRadius.all(Radius.circular(10)),
            //                                 color: Colors.blue
            //                             ),
            //                           ),
            //                           Container(
            //                             height: 50,
            //                             width: 50,
            //                             decoration: BoxDecoration(
            //                                 borderRadius: BorderRadius.all(Radius.circular(10)),
            //                                 color: Colors.green
            //                             ),
            //                           ),
            //                           Container(
            //                             height: 50,
            //                             width: 50,
            //                             decoration: BoxDecoration(
            //                                 borderRadius: BorderRadius.all(Radius.circular(10)),
            //                                 color: Color(0xfff4ca8f)
            //                             ),
            //                           ),
            //                           Container(
            //                             height: 50,
            //                             width: 50,
            //                             decoration: BoxDecoration(
            //                                 borderRadius: BorderRadius.all(Radius.circular(10)),
            //                                 color: Color(0xff3d3a62)
            //                             ),
            //                           )
            //                         ],
            //                       ),
            //                       SizedBox(height: 40,),
            //                       GestureDetector(
            //                         onTap: () => Navigator.pop(context),
            //                         child: Container(
            //                           padding: EdgeInsets.symmetric(vertical: 15),
            //                           width: double.infinity,
            //                           decoration: BoxDecoration(
            //                               borderRadius: BorderRadius.all(Radius.circular(15)),
            //                               color: Color(0xffff96060)
            //                           ),
            //                           child: Center(
            //                             child: Text("Добавить заметку", style: TextStyle(
            //                                 color: Colors.white,
            //                                 fontSize: 18
            //                             ),),
            //                           ),
            //                         ),
            //                       )
            //                     ],
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
          )
      );
    });
  }

  _images() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 12),
            child: Text(
              "Добавьте до 6 фотографий",
            ),
          ),
          Stack(
            children: [
              Container(
                height: 70.0,
                child: CustomScrollView(
                  scrollDirection: Axis.horizontal,
                  primary: false,
                  slivers: <Widget>[
                    SliverPadding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      sliver: SliverGrid.count(mainAxisSpacing: 8, crossAxisCount: 1, childAspectRatio: 1, children: _getListData(context)),
                    ),
                  ],
                ),
              ),
              SmartFlareAnimation()
            ],
          )
        ],
      ),
    );
  }

  _unFocus(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
  }

  String _getAnimationName(AnimationToPlay animationToPlay) {
    switch (animationToPlay) {
      case AnimationToPlay.Activate:
        return 'activate';
      case AnimationToPlay.Deactivate:
        return 'deactivate';
      case AnimationToPlay.CameraTapped:
        return 'camera_tapped';
      case AnimationToPlay.PulseTapped:
        return 'pulse_tapped';
      case AnimationToPlay.ImageTapped:
        return 'image_tapped';
      default:
        return 'deactivate';
    }
  }

  void _setAnimationToPlay(AnimationToPlay animation) {
    var isTappedAnimation = _getAnimationName(animation).contains("_tapped");
    if (isTappedAnimation &&
        _lastPlayedAnimation == AnimationToPlay.Deactivate) {
      return;
    }

    animationControls.play(_getAnimationName(animation));

    _lastPlayedAnimation = animation;
  }

  _getListData(BuildContext context) {
    final ass = Provider.of<Singleton>(context, listen: false).assets;
    List<Widget> widgets = [];
    for (var image in ass) {
      var index = ass.indexOf(image);
      widgets.add(
        Stack(
          children: <Widget>[
            AssetThumb(
              asset: ass[index],
              width: 300,
              height: 300,
            ),
            Positioned(
              top: 3,
              right: 3,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    // deleteFile(index);
                    ass.removeAt(index);
                  });
                },
                child: Icon(Icons.close)
              ),
            ),
          ],
        ),
      );
    }
    // Добавить фотографию
    if (ass.length < 6) {
      widgets.add(
        GestureDetector(
          onTap: () {
            // _unFocus(context);
            // _checkPermission();
          },
          child: Container(
            height: 70,
            width: 70,
            padding: EdgeInsets.all(12),
            child: Transform.translate(
              offset: Offset(2, 2),
              child: SvgPicture.asset(
                "asset/image/add_photo.svg",
              ),
            ),
          ),
        ),
      );
    }
    return widgets;
  }
}

