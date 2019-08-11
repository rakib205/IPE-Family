import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ipe_family/about.dart';
import 'package:ipe_family/add_course.dart';
import 'package:ipe_family/add_member.dart';
import 'package:ipe_family/stuff.dart';
import 'package:ipe_family/update_data.dart';



class DrawerMenu extends StatefulWidget {

  const DrawerMenu({Key key}) : super(key: key);

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
   var textStyle = TextStyle(
              fontFamily: "Raleway",
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 16
            );

  @override
  Widget build(BuildContext context) {
    return 
          Container(
            color: Colors.white,
            child: ListView(
              
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('IPE Family',style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontSize: 20
              ),),

                Text('Together we are',style:TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 14,
                  fontWeight: FontWeight.w600

                ))
                
                    ],
                  )),
                  
                  
                  
                  
                ListTile(
                  leading: Icon(Icons.person_add),
                  title: Text('Add Member',style: textStyle,),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>FormPage()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.update),
                  title: Text('Update Your Data',style: textStyle,),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>UpdataData()));
                  },
                ),
                 ListTile(
                  leading: Icon(Icons.library_add),
                  title: Text('Add Syllabus',style: textStyle),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>AddCourse()));
                  },
                ),
                 ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Officers & Stuffs',style: textStyle,),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => StuffPage()
                    ));
                  },
                ),
                 ListTile(
                  leading: Icon(Icons.details),
                  title: Text('About Developer',style: textStyle,),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>AboutPage()));
                  },
                ),
                
              ],
            ),
          );
        
      
    
  }
}


