import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ipe_family/user_details.dart';
import 'package:url_launcher/url_launcher.dart';

class User {
  String name, regNumber, email, bloodGroup, phone, fbLink,jobTitle,company;
  User(this.name, this.regNumber, this.email, this.bloodGroup, this.fbLink,
      this.phone,this.jobTitle,this.company);
}

List<User> users = List();
List<User> filteredUsers = List();

class DataPage1 extends StatefulWidget {
  _DataPage1State createState() => _DataPage1State();
}

class _DataPage1State extends State<DataPage1> {


  void getData ()async{
    DatabaseReference reference =  FirebaseDatabase.instance.reference();
     reference
    .child('All User')
    
    .once()
    .then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      users.clear();
      
      for (var key in keys) {
        User d = User(
            data[key]['Name'],
            data[key]['Registration Number'],
            data[key]['Email'],
            data[key]['Blood Group'],
            data[key]['Phone'],
            data[key]['Fb Link'],
            data[key]['Job Title'],
            data[key]['Company']
            
            
            );
        users.add(d);
        users.shuffle();
        

        
      }

      

      setState(() {
        users.shuffle();

        filteredUsers = users;
        
      });
    });
  }

  @override
  void initState() {
     getData();
    
    super.initState();
    
  }




  Widget uI() {
    return Container(
      child: Container(
        child: users.length == 0
            ? Center(
        child: FlareActor(
          'assets/images/ipe.flr',
          animation : 'loading',
          color: Colors.deepPurpleAccent,
          alignment: Alignment.center,
          fit: BoxFit.contain,

        
        
        
        ),
      )
            : ListView.builder(
                itemCount: users.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    //margin: EdgeInsets.only(top: 5,bottom: 5),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ListTile(
                        leading: Container(
                          height: 50,
                          width: 50,
                          child: CircleAvatar(
                            child: Text(
                              users[index].bloodGroup,
                              style: TextStyle(
                                  fontFamily: "Raleway",
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                        title: Text(
                          "${users[index].name}",
                          style: TextStyle(
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[800],
                              fontSize: 16),
                        ),
                        subtitle: Container(
                          //height: 65,
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Reg : ${users[index].regNumber}',
                                style: TextStyle(
                                    fontFamily: "Raleway",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[600],
                                    fontSize: 14),
                              ),
                              Row(
                                children: <Widget>[
                                  FlatButton.icon(
                                      color: Colors.grey[200],
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40)),
                                      icon: Icon(Icons.mail),
                                      label: Text(
                                        'mail',
                                        style: TextStyle(
                                            fontFamily: "Raleway",
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,
                                            fontSize: 12),
                                      ),
                                      onPressed: () {
                                        users[index].email.length < 8
                                            ? Scaffold.of(context)
                                                .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Email address is not found!'),
                                              ))
                                            : launch(
                                                'mailto:${users[index].email}');
                                      }),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  FlatButton.icon(
                                    color: Colors.grey[200],
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    icon: Icon(FontAwesomeIcons.facebook),
                                    label: Text(
                                      'fb',
                                      style: TextStyle(
                                          fontFamily: "Raleway",
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                          fontSize: 12),
                                    ),
                                    onPressed: () {
                                      users[index].phone.length == 0
                                          ? Scaffold.of(context)
                                              .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Fb profile is not found!'),
                                            ))
                                          : launch(
                                              "${users[index].phone}", //openning fb
                                              forceWebView: false,
                                              forceSafariVC: false,
                                              universalLinksOnly: true
                                              );
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.call,
                            size: 25,
                          ),
                          onPressed: () {
                            users[index].fbLink.length != 11
                                ? Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('Phone Number is not available!'),
                                  ))
                                : launch("tel:${users[index].fbLink}");
                          },
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => UserDetailsPage(users[index].name, users[index].fbLink, users[index].bloodGroup, users[index].email, users[index].phone,users[index].jobTitle,users[index].company)
                          ));

                          
                        },
                        
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return uI();
  }
}

class DataSearch1 extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // after list item click
    
    return null;
  }

  Widget beforeSearchUI() {
    List hintList = [
      
      'Search by Name, to find specific person.',
      "Search by Registration No, to search an entire batch or search a specific person from a batch. Example : type '2014' to see all members from 2014 batch.",
      "Type 'CR' to find Class Representatives of all batches.",
      'Search By Blood Group.',
      'Search by Company/Organization name.'
    
    ];
    var textStyle = TextStyle(
        fontFamily: 'Raleway', fontWeight: FontWeight.w600, fontSize: 15);
    return Padding(
      padding: const EdgeInsets.only(top: 40,left: 10,right: 2),
      child: Column(
        children: <Widget>[
          Icon(FontAwesomeIcons.search,size: 60,color: Colors.grey,),
          Container(
            child: Expanded(
                child: ListView.builder(
                itemCount: hintList.length,
                itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('${index+1}',style:textStyle),
                      ),
                      title: Text(hintList[index],style: textStyle,),),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Divider(height: 2,),
                      ),
                  ],
                );
               },
              ),
            ),
          ),
        ],
      ),
    );
    
    
    
    
    
    
    
  }

  Widget afterSearchUI() {
    filteredUsers = users
        .where((u) => (u.name.toLowerCase().contains(query.toLowerCase()) ||
            u.email.toLowerCase().contains(query.toLowerCase()) ||
            u.regNumber.toLowerCase().contains(query.toLowerCase()) ||
            u.company.toLowerCase().contains(query.toLowerCase()) ||
            u.bloodGroup.toLowerCase().contains(query.toLowerCase())))
        .toList();
    return ListView.builder(
      itemCount: filteredUsers.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          //margin: EdgeInsets.only(top: 5,bottom: 5),
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ListTile(
              leading: Container(
                height: 50,
                width: 50,
                child: CircleAvatar(
                  child: Text(
                    filteredUsers[index].bloodGroup,
                    style: TextStyle(
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 18),
                  ),
                ),
              ),
              title: Text(
                "${filteredUsers[index].name}",
                style: TextStyle(
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 16),
              ),
              subtitle: Container(
                //height: 65,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Reg : ${filteredUsers[index].regNumber}',
                      style: TextStyle(
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: 14),
                    ),
                    Row(
                      children: <Widget>[
                        FlatButton.icon(
                            color: Colors.grey[200],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            icon: Icon(Icons.mail),
                            label: Text(
                              'mail',
                              style: TextStyle(
                                  fontFamily: "Raleway",
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                  fontSize: 12),
                            ),
                            onPressed: () {
                              filteredUsers[index].email.length < 8
                                  ? Scaffold.of(context).showSnackBar(SnackBar(
                                      content:
                                          Text('Email profile is not found!'),
                                    ))
                                  : launch(
                                      'mailto:${filteredUsers[index].email}');
                            }),
                        SizedBox(
                          width: 5,
                        ),
                        FlatButton.icon(
                          color: Colors.grey[200],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          icon: Icon(FontAwesomeIcons.facebook),
                          label: Text(
                            'fb',
                            style: TextStyle(
                                fontFamily: "Raleway",
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: 12),
                          ),
                          onPressed: () {
                            filteredUsers[index].phone.length == 0
                                ? Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('Fb profile is not found!'),
                                  ))
                                : launch("${filteredUsers[index].phone}");
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.call,
                  size: 25,
                ),
                onPressed: () {
                  filteredUsers[index].fbLink.length != 11
                      ? Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('Phone Number is not available!'),
                        ))
                      : launch("tel:${filteredUsers[index].fbLink}");
                },
              ),
              onTap: () {
                 Navigator.push(context, MaterialPageRoute(
                            builder: (context) => UserDetailsPage(filteredUsers[index].name, filteredUsers[index].fbLink, filteredUsers[index].bloodGroup, filteredUsers[index].email, filteredUsers[index].phone,filteredUsers[index].jobTitle,filteredUsers[index].company)
                          ));
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return beforeSearchUI();
    } else {
      return afterSearchUI();
    }
  }
}
