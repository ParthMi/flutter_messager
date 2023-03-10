import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterfire/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterfire/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messager',
      debugShowCheckedModeBanner: false,
      home: splash(),
    );
  }
}
