import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ipe_family/splash.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';




void main() {
  runApp(MyApp());
  
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //systemNavigationBarColor: Colors.blue, // navigation bar color
    statusBarColor: Colors.white, // status bar color
  ));
  OneSignal.shared.init("ef8761e3-824b-4f63-b522-fff572baf8d5");
 
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Define the default Brightness and Colors
        brightness: Brightness.light,
        primaryColor: Colors.blueAccent,
        primarySwatch: Colors.blue,
        accentColor: Colors.blueAccent,
      ),
      home: SplashPage()
    );
  }
}
