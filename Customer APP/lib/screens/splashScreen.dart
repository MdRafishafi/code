import 'dart:async';
import 'package:MyBMTC/helper/fontCustomizer.dart';
import 'package:lottie/lottie.dart';
import 'package:MyBMTC/screens/onboardingScreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4),
        () => Navigator.pushReplacementNamed(context, OnboardingScreen.route));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final Shader linearGradient = LinearGradient(
      colors: <Color>[Color(0xff864000), Color(0xff85603f), Color(0xff9e7540)],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: height / 40,
          ),
          Container(
              child: Image.asset('assets/icon/bmtclogowhite.png'),
              height: height / 2.5),
          // Text(
          //   'MyBMTC',
          //   style: TextStyle(
          //       fontWeight: FontWeight.bold,
          //       fontSize: FontCustomizer.textFontSize(
          //           fontSize: 45, screenWidth: width),
          //       // fontFamily: 'Cinzel',
          //       foreground: Paint()..shader = linearGradient),
          // ),
          // Container(child: Lottie.asset('assets/lottie/loading.json'),height: height/5,width: width-4),
          Container(
              child: Lottie.asset('assets/lottie/movingbus.json'),
              height: height / 5,
              width: width - 4),
        ],
      ),
    );
  }
}
