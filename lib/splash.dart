import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire/home.dart';
import 'package:flutterfire/login.dart';

class splash extends StatefulWidget {
  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  static const colorizeColors = [
    Color.fromARGB(255, 51, 173, 255),
    Color.fromARGB(255, 0, 114, 190),
    Color.fromARGB(255, 255, 255, 255),
    Color.fromARGB(255, 0, 114, 190),
    Color.fromARGB(255, 51, 173, 255),
    Color.fromARGB(255, 0, 114, 190),
    Color.fromARGB(255, 255, 255, 255),
    Color.fromARGB(255, 0, 114, 190),
  ];
  static const colorizeTextStyle = TextStyle(
    fontSize: 50.0,
    fontWeight: FontWeight.w700,
    fontFamily: 'Horizon',
  );
  @override
  void initState() {
    super.initState();
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Timer(Duration(seconds: 1), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => home()));
      });
    } else {
      Timer(Duration(seconds: 1), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => login()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 255, 255, 255),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                  child: AnimatedTextKit(animatedTexts: [
                ColorizeAnimatedText(
                  'Messager',
                  textStyle: colorizeTextStyle,
                  colors: colorizeColors,
                ),
              ])),
            )
          ],
        ),
      ),
    );
  }
}
