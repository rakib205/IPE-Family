import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TeachersData {
  String name, title, email, phone, profileLink, bioLink,indexList;
  TeachersData(this.name, this.title, this.email, this.phone, this.profileLink,
      this.bioLink,this.indexList);
}

class TeachersPage extends StatefulWidget {
  TeachersPage({Key key}) : super(key: key);

  _TeachersPageState createState() => _TeachersPageState();
}

class _TeachersPageState extends State<TeachersPage> {
  List<TeachersData> allData = [];
  


  var textStyle = TextStyle(
      fontFamily: "Raleway",
      fontWeight: FontWeight.w700,
      color: Colors.black,
      fontSize: 16);

  var textStyle1 = TextStyle(
      fontFamily: "Raleway",
      fontWeight: FontWeight.w500,
      //color: Colors.grey,
      fontSize: 15);

  var textStyle2 = TextStyle(
    fontFamily: "Raleway",
    fontWeight: FontWeight.w600,
  );



  void getData()async {
    DatabaseReference reference = FirebaseDatabase.instance.reference();
    allData.length == 0
        ? await reference
            .child('teachers')
            .orderByKey()
            //.orderByChild('index')
            .once()
            .then((DataSnapshot snap) {
            var keys = snap.value.keys;

            var data = snap.value;
            allData.clear();

            for (var key in keys) {
              TeachersData d = TeachersData(
                  data[key]['bio link'],
                  data[key]['email'],
                  data[key]['name'],
                  data[key]['phone'],
                  data[key]['profile link'],
                  data[key]['index'],
                  data[key]['title']);

              
              allData.add(d);
              allData.sort((a,b) => a.bioLink.compareTo(b.bioLink));  //biolink = index
              
            }

            setState(() {
              
            });
          })
        : teachersUi();
  }

  @override
  void initState() {
    getData();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return teachersUi();
  }

  Scaffold teachersUi() {
    return Scaffold(
        body: allData.length == 0
            ? Center(
        child: FlareActor(
          'assets/images/ipe.flr',
          animation : 'loading',
          color: Colors.deepPurpleAccent,
          alignment: Alignment.center,
          fit: BoxFit.contain,

        
        
        
        ),
      )
            : Container(
                child: ListView.builder(
                  itemCount: allData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              FadeInImage.assetNetwork(
                                placeholder: "assets/images/loading.gif",
                                image: "${allData[index].profileLink}",
                              ),
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  height: 55,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.grey[200].withOpacity(0.8),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                            "${allData[index].email}", //name>email,title>biolink,email>title,biolink>name
                                            style: textStyle),
                                        Text(
                                          '${allData[index].indexList}',
                                          style: textStyle1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FlatButton.icon(
                                  color: Colors.grey[200],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40)),
                                  icon: Icon(Icons.mail),
                                  label: Text(
                                    'mail',
                                    style: textStyle2,
                                  ),
                                  onPressed: () {
                                    launch('mailto:${allData[index].email}');
                                    
                                  }),
                              SizedBox(
                                width: 5,
                              ),
                              FlatButton.icon(
                                color: Colors.grey[200],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                icon: Icon(Icons.call),
                                label: Text(
                                  'phone',
                                  style: textStyle2,
                                ),
                                onPressed: () {
                                  launch("tel:${allData[index].phone}");
                                },
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              FlatButton.icon(
                                color: Colors.grey[200],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                icon: Icon(Icons.explore),
                                label: Text(
                                  'more',
                                  style: textStyle2,
                                ),
                                onPressed: () {
                                  launch("${allData[index].name}");
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ));
  }
}
