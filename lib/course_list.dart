import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class FoldingCellListViewDemo extends StatefulWidget {
  @override
  _FoldingCellListViewDemoState createState() =>
      _FoldingCellListViewDemoState();
}

class _FoldingCellListViewDemoState extends State<FoldingCellListViewDemo> {
  
  List courseData = [] ;
  var textStyle = TextStyle(
              fontFamily: "Raleway",
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 17
              
            );

  var textStyleButton = TextStyle(
              fontFamily: "Raleway",
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: Colors.black,
              
            );

        

  var semesterSelection ;
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
  
  
  void getData() {
    courseData =[];
    databaseReference.child('course/$semesterSelection').once().then((DataSnapshot snap) {
      var val = snap.value;
      print(val);

      setState(() {
        this.courseData = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 8,
      itemBuilder: (BuildContext context, int index) {
      return Container(
        
        
        child: ExpansionTile(
          
          onExpansionChanged: (val){
            setState(() {
                      
                      this.semesterSelection ='Semester-${index+1}';
                      getData();
                    });
          },
          leading: Icon(LineIcons.book),
          title: Text("SEMESTER - ${index + 1}",style: textStyle,),
          children: <Widget>[
            
            Container(
              height: 480,
              child: courseData.length == 0 ? 

              Container(child: Center(child: CircularProgressIndicator(),),) : 

             Padding(
          padding: EdgeInsets.only(bottom: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(child :
                  ListView.builder(
                  itemCount: courseData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 10, top: 0, right: 0, bottom: 0),
                      child: ListTile(
                        
                        leading: CircleAvatar(

                          radius: 15,
                            //backgroundColor: Colors.white,
                            child: Text("${index + 1}",style: TextStyle(color: Colors.white),)),
                        title: Text(
                          courseData[index],
                           style: textStyleButton,
                        ),
                      ),
                    );
                  },
                ),
                ),
              
            ],
          ),
        ),
              
            ),

            
      
          ],
          
          ),
          

      );
     },
    );
}
}