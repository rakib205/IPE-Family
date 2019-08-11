
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/services.dart';
import 'package:ipe_family/course_list.dart';
import 'package:ipe_family/data1.dart';

import 'package:ipe_family/drawer.dart';
import 'package:ipe_family/internet.dart';
import 'package:ipe_family/teachers.dart';
import 'package:connectivity/connectivity.dart';












class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget screen = DataPage1();

  var setTitle = 'IPE Family';
  var internetCheck = 1;
  var silverTitle = 'All Members';
  var silverSubtitle = 'Including First Batch to Present Batch';




  checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      
      setState(() {
        internetCheck = 0;
        screen = NoInternetPage();
      });
      
    } else {
      
      setState(() {
        internetCheck = 1;
        screen = DataPage1();
      });
    }
  }

  checkInternet1 () async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    connectivityResult == ConnectivityResult.none ? 
    setState(() {
        internetCheck = 0;
        
      })
    : setState(() {
        internetCheck = 1;
        
      });  
  }


   void notificationClicked(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Under Development',style: TextStyle(fontFamily: 'Raleway',fontWeight: FontWeight.w600),),
          actions: <Widget>[
            FlatButton(child: Text('OK',), onPressed: () {
              Navigator.pop(context);
              
              
              
              
            },)
          ],
        );
      }
      
    );
  }

  
  whenBackButtonClicked(){
    
    SystemNavigator.pop();
  }
 

 Widget bottomNav(){
   return
    FancyBottomNavigation(

            activeIconColor: Colors.white,
            circleColor: Colors.deepPurpleAccent,
            inactiveIconColor: Colors.deepPurpleAccent,
            initialSelection: 1,
            tabs: [
              TabData(iconData: Icons.assignment, title: "Syllabus"),
              TabData(iconData: Icons.search, title: "Members"),
              TabData(iconData: Icons.supervisor_account, title: "Teachers"),
            ],
            onTabChangedListener: (position) {
              setState(() {
                //currentPage = position;
                checkInternet1();
                if(internetCheck==0){
                  screen = NoInternetPage();
                }
                else if (position == 1) {

                  setState(() {
                    silverTitle = 'All Members';
                    silverSubtitle = 'Including First Batch to Present Batch';
                  });
                  screen = DataPage1();
                } else if (position == 0) {
                  setState(() {
                    silverTitle = 'Syllabus Details';
                    silverSubtitle = 'Including First to Last Semester';
                  });
                  screen = FoldingCellListViewDemo();
                } else {
                  setState(() {
                    silverTitle = 'All Teachers';
                    silverSubtitle = 'Details About All Teachers';
                  });
                  screen = TeachersPage();
                }
              });
            },
          );
  }


 

  @override
  void initState() {
    checkInternet();
    
    setState(() {
      
    });
    super.initState();
  }

 

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
          onWillPop: (){
            return
            whenBackButtonClicked();
          },

          
          child: Scaffold(
          drawer: Drawer(
            
            child: DrawerMenu()

          ),
          appBar: AppBar(
            actionsIconTheme: IconThemeData(color: Colors.black),
            automaticallyImplyLeading: true,
            iconTheme: IconThemeData(color: Colors.black),
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            centerTitle: false,
            elevation: 2,
            title: Text(
              setTitle,
              style: TextStyle(
                fontFamily: "Raleway",
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontSize: 18
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: DataSearch1());
                },
              ),
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  notificationClicked();
                },
              )
            ],
          ),
          bottomNavigationBar: FancyBottomNavigation(

            activeIconColor: Colors.white,
            circleColor: Colors.deepPurpleAccent,
            inactiveIconColor: Colors.deepPurpleAccent,
            initialSelection: 1,
            tabs: [
              TabData(iconData: Icons.assignment, title: "Syllabus"),
              TabData(iconData: Icons.search, title: "Members"),
              TabData(iconData: Icons.supervisor_account, title: "Teachers"),
            ],
            onTabChangedListener: (position) {
              setState(() {
                //currentPage = position;
                checkInternet1();
                if(internetCheck==0){
                  screen = NoInternetPage();
                }
                else if (position == 1) {

                  
                  screen = DataPage1();
                } else if (position == 0) {
                  
                  screen = FoldingCellListViewDemo();
                } else {
                  
                  screen = TeachersPage();
                }
              });
            },
          ),
          body: AnimatedSwitcher(
            transitionBuilder: (Widget child, Animation<double> animation) {
                return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
              },
            duration: Duration(milliseconds: 400),
            child: screen,
          )
          ),
    );
  }

  




}
