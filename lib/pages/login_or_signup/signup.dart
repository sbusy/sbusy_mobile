import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'login.dart';
import '../home/home.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/textfield_widget.dart';
import '../../widgets/wave_widget.dart';
import '../../widgets/fade_animation.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> with SingleTickerProviderStateMixin {
  AnimationController _scaleController;
  Animation<double> _scaleAnimation;

  bool hide = false;

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
        Navigator.push(context, PageTransition(
            child: Home(),
            type: PageTransitionType.fade
        ));
        Future.delayed(Duration(seconds: 1)).then((value) {
          _scaleController.reset();
          setState(() => hide = false);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: size.height - 200,
                color: Color.fromARGB(255, 102, 18, 222),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeOutQuad,
                top: keyboardOpen ? -size.height / 3.7 : 0.0,
                child: WaveWidget(
                  size: size,
                  yOffset: size.height / 3.0,
                  color: Colors.white
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
                        'Зарегистрироваться',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FadeAnimation(
                      0.5,
                      TextFieldWidget(
                        hintText: 'Email',
                        obscureText: false,
                        prefixIconData: Icons.mail_outline,
                        // suffixIconData: model.isValid ? Icons.check : null,
                        // onChanged: (value) {
                        //   model.isValidEmail(value);
                        // },
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    FadeAnimation(
                      0.75,
                      TextFieldWidget(
                        hintText: 'Пароль',
                        obscureText: false,
                        prefixIconData: Icons.lock_outline,
                        // suffixIconData: model.isVisible
                        //     ? Icons.visibility
                        //     : Icons.visibility_off,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    FadeAnimation(
                    1,
                      TextFieldWidget(
                        hintText: 'Повторите пароль',
                        obscureText: false,
                        prefixIconData: Icons.lock_outline,
                        // suffixIconData: model.isVisible
                        //     ? Icons.visibility
                        //     : Icons.visibility_off,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    FadeAnimation(
                      1.25,
                      ButtonWidget(
                        title: 'Зарегистрироваться',
                        hasBorder: true,
                        onPress: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home())
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    FadeAnimation(
                      1.5,
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Login())
                            );
                          },
                          child: Text(
                            'Уже есть аккаунт? Войдите',
                            style: TextStyle(
                              color: Color.fromARGB(255, 102, 18, 222),
                            ),
                          ),
                        )
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}