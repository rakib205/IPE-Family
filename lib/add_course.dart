import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class AddCourse extends StatefulWidget {
  _AddCourseState createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  final databaseReference = FirebaseDatabase.instance.reference();

  var formKey = GlobalKey<FormState>();

  List courseList = [];
  var semester;
  var semester1 = '';
  String alertMessage = '';
  var semesterData = ['Semester-1','Semester-2','Semester-3','Semester-4','Semester-5','Semester-6','Semester-7','Semester-8'];
  var internetCheck = 0;

  var textStyle = TextStyle(
    fontFamily: 'Raleway',
    fontWeight: FontWeight.w600
  );



   checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      
      setState(() {
        this.internetCheck = 0;
      });
      
    } else {
      
      setState(() {
        this.internetCheck =1;
        
      });
    }
  }

     checkInternet1() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      
      setState(() {
        this.internetCheck = 0;
      });
      
    } else {
      
      setState(() {
        this.internetCheck =1;
        crDialog();
      });
    }
  }

  @override
  void initState() {
    
    checkInternet();
    checkInternet1();
    
    super.initState();
  }

  void showDialogs() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(alertMessage,style: textStyle,),
            actions: <Widget>[
              FlatButton(
                child: Text('OK',style: textStyle,),
                onPressed: () {
                  Navigator.pop(context);
                  if (alertMessage=='Saved Successfully') {
                    Navigator.pop(context);
                  }
                },
              )
            ],
          );
        });
  }

  void crDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("This feature is only for the 'Class Representatives' of current batches. Please don't input anything if you are not one of them.",style: textStyle,),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok,Got It',style: textStyle,),
                onPressed: () {
                  Navigator.pop(context);
                  
                },
              )
            ],
          );
        });
  }

  void handleSubmit() {
    checkInternet();
    if (semester1.length == 0) {
      setState(() {
        alertMessage = 'Select Semester First!';
      });
      showDialogs();
    }
     else if(internetCheck ==0){
       setState(() {
         alertMessage = 'No internet connection!';
         showDialogs();
       });
       
     }
    
    
     else {
      setState(() {
        alertMessage = 'Saved Successfully';
      });

      formKey.currentState.save();
      uploadData();
      showDialogs();
    }
  }

  void uploadData() {
    databaseReference.child("course/$semester").set(courseList);

    courseList.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Syllabus',
          style: TextStyle(
              fontFamily: "Raleway",
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontSize: 18),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {
            crDialog();
          },)
        ],
      ),
      body: Form(
          key: formKey,
          child: Container(
              child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Container(
                  //height: 55,
                  child: DropdownButtonFormField(
                      onChanged: (val) {
                        setState(() {
                          this.semester = val;
                          this.semester1 = val;
                        });
                      },
                      value: semester,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      hint: Text(
                        'Select Semester',
                        style: TextStyle(
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      items: semesterData.map((String dropItem){
                        return DropdownMenuItem<String>(
                          value: dropItem,
                          child: Text(dropItem,style: TextStyle(fontFamily: 'Raleway',fontWeight: FontWeight.w600,color: Colors.black)),
                        );
                      }).toList()
                      
  
                      
                      
                      
                      
                      ),
                ),
                SizedBox(
                  height: 4,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Container(
                          //height: 55,
                          child: TextFormField(
                            style: TextStyle(
                                fontFamily: "Raleway",
                                fontWeight: FontWeight.w600,
                              ) ,
                            decoration: InputDecoration(
                              // border: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(0)),
                              labelStyle: TextStyle(
                                  fontFamily: "Raleway",
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                              hintText: "Enter Course Code & Name",
                              hintStyle: TextStyle(
                                fontFamily: "Raleway",
                                fontWeight: FontWeight.w600,
                              ),
                              labelText: "Course ${index + 1} ",
                              alignLabelWithHint: true,
                              //prefixIcon: Icon(Icons.book),
                            ),
                            onSaved: (val) {
                              if (val.length != 0) {
                                courseList.add(val);
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    height: 45,
                    width: 150,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      color: Colors.deepPurpleAccent,
                      child: Text(
                        'Save',
                        style: TextStyle(
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 18),
                      ),
                      onPressed: () {
                        setState(() {
                          handleSubmit();
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ))),
    );
  }
}
