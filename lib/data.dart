import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DataTest extends StatefulWidget {
  DataTest({Key key}) : super(key: key);

  _DataTestState createState() => _DataTestState();
}


// void updateData() {
//   DatabaseReference reference = FirebaseDatabase.instance.reference();

//   reference.child('All User').once().then((DataSnapshot snap){
//     var keys = snap.value.keys;

//     for (var key in keys){
//      reference.child('All User/$key').update({
//     'Job Title': '',
//     'Company' : ''
//   });

  
//     }
//   });


// }


void exist (){

 
 
 DatabaseReference reference = FirebaseDatabase.instance.reference();

 reference.child('All User').once().then((DataSnapshot snap){

   List keys =snap.value.keys.toList();

   if(keys.contains('2014334058')){
     print('yes');
   }
   else{
     print('no');
   }

   

   




 });






}



class _DataTestState extends State<DataTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(onPressed: () {
          //updateData();
          exist();
                  },),
                ),
              );
            }
          
            
}