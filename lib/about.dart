import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  



  @override
  Widget build(BuildContext context) {
      var ts = TextStyle(
    fontFamily: 'Raleway',
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

   var ts1 = TextStyle(
    fontFamily: 'Raleway',
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

    return Scaffold(
      appBar: AppBar(
        title: Text('About Developer',style: TextStyle(
              fontFamily: "Raleway",
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontSize: 18
            ),),
        actionsIconTheme: IconThemeData(color: Colors.black),
          
          iconTheme: IconThemeData(color: Colors.black),
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 1,
        
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0)
        ),
        elevation: 50,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10,),
              Container(
                  height: 200,
                  width: 200,
                  child: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/images/dev.jpg'))),
              SizedBox(height: 10,),        
              Text("Designed & Developed By",style: TextStyle(
              fontFamily: "Raleway",
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontSize: 15
            ),),
              Text('Mohammad Rakib Bhuiyan',style: TextStyle(
              fontFamily: "Raleway",
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 20
            ),),
              Text('From IPE 20th Batch',style: TextStyle(
              fontFamily: "Raleway",
              fontWeight: FontWeight.w500,
              //color: Colors.black,
              fontSize: 14
            ),),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    
                    child: CircleAvatar(
                      child: Icon(FontAwesomeIcons.facebookF),
                    ), onPressed: () {
                      launch(
        'https://facebook.com/rakib.bhujyan',
        forceSafariVC: false,
        universalLinksOnly: true,
      );
                    },
                  ),
                  FlatButton(
                    child: CircleAvatar(
                      child: Icon(Icons.email),
                    ), onPressed: () {
                      launch('mailto:rakib205?subject=About IPE Family App&body=');
                    },
                  ),
                  FlatButton(
                    child: CircleAvatar(
                      child: Icon(FontAwesomeIcons.github),
                    ), onPressed: () {
                      launch('https://github.com/rakib205');
                    },
                  ),
                  
                ],
              ),
              SizedBox(height: 30,)
            ],
        ),
      ),
          ),
      SizedBox(height: 40,),
      Padding(
        padding: const EdgeInsets.only(top: 10,left: 15),
        child: Text('Thanks to',
          style: TextStyle(
                fontFamily: "Raleway",
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 16
              ),
          ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Divider(color: Colors.grey,),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          children: <Widget>[
            
            ListTile(
              leading: CircleAvatar(
                child: Icon(LineIcons.user),
                
              ),
              title: Text('Md Mehedi Hasan Kibria',style: ts,),
              subtitle: Text('Lecturer, IPE',style: ts1,),
            )
            
            ,ListTile(
              leading: CircleAvatar(
                child: Icon(LineIcons.user),
                
              ),
              title: Text('Qausar Rahman',style: ts,),
              subtitle: Text('IPE 21st Batch',style: ts1,),
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(LineIcons.user),
                
              ),
              title: Text('Md Nazmul Hasan Dipu',style: ts,),
              subtitle: Text('IPE 21st Batch',style: ts1,),
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(LineIcons.user),
                
              ),
              title: Text('Akram Kabir',style: ts,),
              subtitle: Text('IPE 22nd Batch',style: ts1,),
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(LineIcons.user),
                
              ),
              title: Text('Md Mehedi Hasan Niloy',style: ts,),
              subtitle: Text('IPE 23rd Batch',style: ts1,),
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(LineIcons.user),
                
              ),
              title: Text('Ahmed Refie',style: ts,),
              subtitle: Text('IPE 24th Batch',style: ts1,),
            )
          ],
        ),
        
      ),

      Padding(
        padding: const EdgeInsets.only(top: 20,left: 15),
        child: Text('',
          style: TextStyle(
                fontFamily: "Raleway",
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 16
              ),
          ),
      ),
      SizedBox(height: 20,)
        ],
      )
    );
  }
}
