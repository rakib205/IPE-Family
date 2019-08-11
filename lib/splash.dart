

import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:ipe_family/home.dart';
import 'package:ipe_family/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {



  Widget screen;

 

 afterSplash()async{
   var duration = Duration(milliseconds: 4000);
   return Timer(duration, nextPage);
 }
 
 void nextPage(){


  //  Navigator.push(context, MaterialPageRoute(
  //    builder: (context) => screen
  //  ));

  Navigator.push(context, MaterialPageRoute(builder: (_) {
            return screen;
          }));
  

   
   
 }


   check() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    //sp.setInt('counter', 0);
    int c = (sp.getInt('counter') ?? 0);

    c==0
    ? setState(() {
        screen = WelcomePage();
      })
    : setState(() {
        screen = HomePage();
      }); 

    // if(c==0){
    //   setState(() {
    //     screen = WelcomePage();
    //   });
      
    // }
    // else{
    //   setState(() {
    //     screen = HomePage();
    //   });
    // }
  }
 

  @override
  void initState() {
    check();
    afterSplash();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Hero(
          tag: 'splash',
          child: FlareActor(
            'assets/images/ipe.flr',
            animation : 'loading',
            color: Colors.deepPurpleAccent,
            alignment: Alignment.center,
            fit: BoxFit.contain,

          
          
          
          ),
        ),
      )
    );
  }
}