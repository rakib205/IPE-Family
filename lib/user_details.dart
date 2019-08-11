import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class UserDetailsPage extends StatefulWidget {
  
  final String name,bloodGroup,email,phone,fb,jobTitle,company;
  UserDetailsPage(this.name,this.phone,this.bloodGroup,this.email,this.fb,this.jobTitle,this.company);

  _UserDetailsPageState createState() => _UserDetailsPageState(this.name,this.phone,this.bloodGroup,this.email,this.fb,this.jobTitle,this.company);
}

class _UserDetailsPageState extends State<UserDetailsPage> {

  String name,bloodGroup,email,phone,fb,jobTitle,company;
  _UserDetailsPageState(this.name,this.phone,this.bloodGroup,this.email,this.fb,this.jobTitle,this.company);


   var textStyle1 = TextStyle(
      fontFamily: "Raleway",
      fontWeight: FontWeight.w500,
      //color: Colors.grey,
      fontSize: 13);

  var textStyle2 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.grey[900],
    fontFamily: 'Raleway'
    
    );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        iconTheme: IconThemeData(color: Colors.black),
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
      ),
      body: 
      SingleChildScrollView(
        child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            color: Colors.white,
            height: 190,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                radius: 55,
                child: Icon(Icons.person,size: 45,),
              ),
              SizedBox(height: 10,),
              Text(name,style: TextStyle(
                fontFamily:'Raleway',
                fontSize: 20,
                fontWeight: FontWeight.w600 )),
                SizedBox(height: 10,)
                ],
              )
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.grey[100],
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text('Phone',style: textStyle1),
                  subtitle: Text(phone,style: textStyle2),
                  trailing: IconButton(icon: Icon(Icons.call,color: Colors.grey[800],), onPressed: () {
                    launch("tel:$phone");
                  },),
                  
                ),
                Divider(),
                 ListTile(
                  title: Text('Email',style: textStyle1),
                  subtitle: Text(email,style: textStyle2),
                  trailing: IconButton(icon: Icon(Icons.mail,color: Colors.grey[800],), onPressed: () {
                    launch('mailto:$email');
                  },),
                  
                ),
                Divider(),
                 ListTile(
                  title: Text('Blood Group',style: textStyle1,),
                  subtitle: Text(bloodGroup,style: textStyle2),
                  trailing: IconButton(icon: Icon(Icons.opacity), onPressed: () {},),
                  
                ),
                Divider(),
                 ListTile(
                  title: Text('Facebook ID',style: textStyle1),
                  subtitle: Text(fb,style: textStyle2),
                  trailing: IconButton(icon: Icon(FontAwesomeIcons.facebook,color: Colors.grey[800],), onPressed: () {
                    launch(fb, //openning fb
                                              // forceWebView: false,
                                              // forceSafariVC: false,
                                              // universalLinksOnly: true
                                              );
                  },),
                  
                ),
                Divider(),
                 ListTile(
                  title: Text('Current Job Details',style: textStyle1),
                  subtitle: Text('$jobTitle, $company',style: textStyle2),
                  trailing: IconButton(icon: Icon(Icons.work), onPressed: () {},),
                  
                ),
               
              ],
            )
            
            
          )
        ],
      ),
      )
      
      
      
    );
}

}