import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class UpdataData extends StatefulWidget {
  _UpdataDataState createState() => _UpdataDataState();
}

class _UpdataDataState extends State<UpdataData> {

  

  final databaseReference = FirebaseDatabase.instance.reference();

  var formKey = GlobalKey<FormState>();

  var nameCtrl = TextEditingController();
  var phoneCtrl = TextEditingController();
  var emailCtrl = TextEditingController();
  var regCtrl = TextEditingController();
  var fbLinkCtrl = TextEditingController();
  var jobTitleCtrl = TextEditingController();
  var companyCtrl = TextEditingController();
  

  var batch, name, phone, regNo, bloodGroup, fbLink, email, jobTitle, company;
  var batch1 = '';
  var bloodGroup1 = '';
  String alertMessage = '';

  var textStyle = TextStyle(
              fontFamily: "Raleway",
              fontWeight: FontWeight.w600,
              color: Colors.black,
              
            );

  var textStyle1 = TextStyle(
              fontFamily: "Raleway",
              fontWeight: FontWeight.w600,
              
              
            );
  var bloodGroupData = ['A+','A-','B+','B-','O+','O-','AB+','AB-','N/A'] ;
  var batchData = ['1st Batch','2nd Batch','3rd Batch','4th Batch','5th Batch','6th Batch','7th Batch','8th Batch',
  '9th Batch','10th Batch','11th Batch','12th Batch','13th Batch','14th Batch','15th Batch','16th Batch','17th Batch','18th Batch','19th Batch'
  ,'20th Batch','21st Batch','22nd Batch','23rd Batch','24thth Batch','25th Batch','26th Batch','27th Batch','28th Batch','29th Batch',
  '30th Batch','31st Batch','32th Batch','33th Batch','34th Batch','35th Batch','36th Batch','37th Batch','38th Batch','39th Batch','40th Batch'
  
  
  ];

  var internetCheck = 0;

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

  @override
  void initState() {
    checkInternet();
    super.initState();
  }

   void showDialogs(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(alertMessage,style: textStyle1,),
          actions: <Widget>[
            FlatButton(child: Text('OK',style: textStyle1,), onPressed: () {
              Navigator.pop(context);
              if(alertMessage== 'Updated Successfully'){
                Navigator.pop(context);
              }
             
              
              
              
            },)
          ],
        );
      }
      
    );
  }

  void handleSubmit() {
    checkInternet();
    if (batch1.length == 0) {
      setState(() {
        alertMessage = 'Select Batch First';
        showDialogs();
      });
    } else if (bloodGroup1.length == 0) {
      setState(() {
        alertMessage = 'Select Blood Group';
        showDialogs();
      });


      
    } 
    else if (internetCheck==0){
      setState(() {
        alertMessage = 'No internet connection!';
        showDialogs();
      });
    }
    
    else if (formKey.currentState.validate()) {
      formKey.currentState.save();
      uploadData();
      setState(() {
        alertMessage = 'Updated Successfully';
        showDialogs();
      });
    }
  }

  void uploadData() {
   databaseReference.child("All User/$regNo").set({
      'Batch' : batch,
      'Blood Group' : bloodGroup,
      'Email' : email,
      'Fb Link' : fbLink,
      'Name' : name,
      'Phone' : phone,
      'Registration Number' : regNo,
      'Job Title' : jobTitle,
      'Company' : company
    });

    databaseReference.child("Users/$batch/$regNo").set({
      
      'Batch' : batch,
      'Blood Group' : bloodGroup,
      'Email' : email,
      'Fb Link' : fbLink,
      'Name' : name,
      'Phone' : phone,
      'Registration Number' : regNo,
      'Job Title' : jobTitle,
      'Company' : company
    });
  }

  void handleReset() {
    nameCtrl.clear();
    phoneCtrl.clear();
    emailCtrl.clear();
    regCtrl.clear();
    fbLinkCtrl.clear();
    jobTitleCtrl.clear();
    companyCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {

    //TextStyle textStyle = Theme.of(context).textTheme.subtitle;
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Your Data',style: TextStyle(
              fontFamily: "Raleway",
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontSize: 16
            ),),
        iconTheme: IconThemeData(color: Colors.black),
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                 
                  SafeArea(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: 60,
                            child: DropdownButtonFormField(

                                onChanged: (val) {
                                  setState(() {
                                    this.batch = val;
                                    this.batch1 = val;
                                  });
                                },
                                
                                value: batch,
                                decoration: InputDecoration(
                                  
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                hint: Text('Select Batch',style: textStyle,),
                                items: batchData.map((String dropDownStringItem){
                                 return DropdownMenuItem<String>(
                                   value: dropDownStringItem,
                                   child: Text(dropDownStringItem,style: textStyle,),
                                 );
                                }).toList() 
                                
                                
                                ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Container(
                            height: 60,
                            child: DropdownButtonFormField(
                                onChanged: (val) {
                                  setState(() {
                                    this.bloodGroup = val;
                                    this.bloodGroup1 = val;
                                  });
                                },
                                value: bloodGroup,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                hint: Text('Select BG',style: textStyle,),
                                items: bloodGroupData.map((String dropDownStringItem){
                                 return DropdownMenuItem<String>(
                                   value: dropDownStringItem,
                                   child: Text(dropDownStringItem,style: textStyle,),
                                 );
                                }).toList()
                                
                                
                                
                                
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    //height: 55,
                    child: TextFormField(
                        style: textStyle,
                        decoration: InputDecoration(
                            // border: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(5)),
                            hintText: "Enter Name",
                            hintStyle: textStyle1,

                            labelText: "Name",
                            labelStyle: textStyle,
                            alignLabelWithHint: true,
                            //prefixIcon: Icon(Icons.account_circle),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                nameCtrl.clear();
                              },
                            )),
                        controller: nameCtrl,
                        keyboardType: TextInputType.text,
                        
                        //maxLength: 20,

                        validator: (value) { 
                          if (value.length == 0) return ("Name is required");
                          return value = null;
                          
                        },
                        onSaved: (value) {
                          this.name = value;
                          
                        }),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: textStyle,
                      decoration: InputDecoration(
                          // border: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(5)),
                          hintText: "Enter Registration No",
                          hintStyle: textStyle1,
                          labelText: "Registration No",
                          labelStyle: textStyle,
                          alignLabelWithHint: true,
                          //prefixIcon: Icon(Icons.format_list_numbered),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              regCtrl.clear();
                            },
                          )),
                      controller: regCtrl,
                      keyboardType: TextInputType.number,
                      maxLength: 10,

                      validator: (value) {
                        if (value.length != 10) 
                        return ("Registration Number must be 10 digits");
                          return value = null;
                        
                      },
                      onSaved: (value) {
                        this.regNo = value;
                        
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: textStyle,
                      decoration: InputDecoration(
                          // border: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(5)),
                          hintText: "Enter Phone Number",
                          hintStyle: textStyle1,
                          labelText: "Phone",
                          labelStyle: textStyle,
                          alignLabelWithHint: true,
                          //prefixIcon: Icon(Icons.phone),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              phoneCtrl.clear();
                            },
                          )),
                      controller: phoneCtrl,
                      keyboardType: TextInputType.phone,
                      maxLength: 11,

                      validator: (value) {
                        if (value.length !=11) 
                        return ("Phone number must be 11 digits");
                          return value = null;
                        
                      },
                      onSaved: (value) {
                        this.phone = value;
                        
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    //height: 55,
                    child: TextFormField(
                      style: textStyle,
                        decoration: InputDecoration(
                            // border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(5)),
                            hintText: "Enter Email",
                            hintStyle: textStyle1,
                            labelStyle: textStyle,
                            labelText: "Email",
                            alignLabelWithHint: true,
                            //prefixIcon: Icon(Icons.email),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                emailCtrl.clear();
                              },
                            )),
                        controller: emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        //maxLength: 20,

                        validator: (value) {
                          if (value.length == 0) return ("Email is required");
                          return value = null;
                          
                        },
                        onSaved: (value) {
                          this.email = value;
                          
                        }),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    // height: 55,
                    child: TextFormField(
                      style: textStyle,
                      controller: fbLinkCtrl,
                        decoration: InputDecoration(
                            // border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(5)),
                            hintText: "Enter/Paste fb profile link (Optional)",
                            labelText: "Fb Link",
                            hintStyle: textStyle1,
                            labelStyle: textStyle,
                            alignLabelWithHint: true,
                            //prefixIcon: Icon(Icons.insert_link),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                fbLinkCtrl.clear();
                              },
                            )),
                        
                        
                        //maxLength: 20,

                        
                        onSaved: (value) {
                          this.fbLink = value;
                          
                        }),
                  ),

                SizedBox(
                    height: 10,
                  ),
                  Container(
                    // height: 55,
                    child: TextFormField(
                      style: textStyle,
                      controller: jobTitleCtrl,
                        decoration: InputDecoration(
                            
                            hintText: "Enter Your Job Title (Optional)",
                            labelText: "Job Title (Optional)",
                            hintStyle: textStyle1,
                            labelStyle: textStyle,
                            alignLabelWithHint: true,
                            //prefixIcon: Icon(Icons.insert_link),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                jobTitleCtrl.clear();
                              },
                            )),
                        
                        
                        

                        
                        onSaved: (value) {
                          this.jobTitle = value;
                          
                        }),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    // height: 55,
                    child: TextFormField(
                      style: textStyle,
                      controller: companyCtrl,
                        decoration: InputDecoration(
                            
                            hintText: "Enter Your Organization Name (Optional)",
                            labelText: "Company Name (Optional)",
                            hintStyle: textStyle1,
                            labelStyle: textStyle,
                            alignLabelWithHint: true,
                            //prefixIcon: Icon(Icons.insert_link),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                companyCtrl.clear();
                              },
                            )),
                        
                        
                        

                        
                        onSaved: (value) {
                          this.company = value;
                          
                        }),
                  ),

                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  
                  height: 45,
                  width: 150,
                  child: FlatButton(
                    
                    color: Colors.deepPurpleAccent,
                    
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)
                    ),
                    child: Text("Update",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w600
                      ),
                    ),
                    onPressed: () {
                      handleSubmit();
                    },
                  ),
                ),
                // SizedBox(
                //   width: 20,
                // ),
                // RaisedButton(
                //   child: Text("Reset"),
                //   onPressed: () {
                //     handleReset();
                //   },
                // )
              ],
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
