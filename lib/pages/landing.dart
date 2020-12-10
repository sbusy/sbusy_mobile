import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sbusy_mobile/widgets/wave_widget.dart';
import 'onboarding.dart';
import '../widgets/fade_animation.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing>
    with SingleTickerProviderStateMixin {
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
    Future.delayed(Duration(seconds: 5)).then((value) => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Onboarding()
      )
    ));
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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              WaveWidget(
                size: size,
                yOffset: size.height / 3.0,
                color: Color.fromARGB(255, 102, 18, 222),
              ),
              FadeAnimation(
                0.5,
                Image.asset(
                  'asset/image/s-busy.png',
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: FadeAnimation(
                    1,
                      SvgPicture.asset("asset/image/landing.svg")
                  )
              )
            ],
          ),
        ),
      )
    );
  }

  void openOnBoard() => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Onboarding())
  );
}