import 'package:connectivity/connectivity.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StuffData {
  String name, title,phone,indexList;
  StuffData(this.name, this.title,this.phone,this.indexList);
}

class StuffPage extends StatefulWidget {
  StuffPage({Key key}) : super(key: key);

  _StuffPageState createState() => _StuffPageState();
}

class _StuffPageState extends State<StuffPage> {

  
  List<StuffData> alldata = [];

  List datas = [];

  var internetCheck = 1;


  var textStyleBold = TextStyle(
      fontFamily: "Raleway",
      fontWeight: FontWeight.w700,
      color: Colors.grey[800],
      fontSize: 16);

  var textStyle1 = TextStyle(
      fontFamily: "Raleway",
      fontWeight: FontWeight.w500,
      //color: Colors.grey,
      fontSize: 14);

  var textStyle2 = TextStyle(
    fontFamily: "Raleway",
    fontWeight: FontWeight.w600,
  );


  void getData () async{
    DatabaseReference reference = FirebaseDatabase.instance.reference();
  await  reference.child('Stuff').once().then((DataSnapshot snap){

      var keys = snap.value.keys;
      var data = snap.value;
      alldata.clear();

      for(var key in keys){
        StuffData d = StuffData(
          data[key]['name'],
          data[key]['title'],
          data[key]['phone'],
          data[key]['index']
        );

        alldata.add(d);
        alldata.sort(
          (a,b) => a.indexList.compareTo(b.indexList)
        );
        
      }

      setState(() {
        datas = this.alldata;
        print(datas);
      });


    });


  }

    checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      
      setState(() {
        internetCheck = 0;
        
      });
      
    } else {
      
      setState(() {
        internetCheck = 1;
        
      });
    }
  }

  
  

            

  @override
  void initState() {
    checkInternet();
    getData();
    super.initState();
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Text('Officers & Stuffs',style: TextStyle(
              fontFamily: "Raleway",
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontSize: 18
            ),),
        iconTheme: IconThemeData(color: Colors.black),
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 1,
      ),

      body: internetCheck == 0
             ? Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.network_check,size: 50,color: Colors.grey,),
            Text('No internet connection!',style:TextStyle(
              fontFamily: 'Raleway',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey
            ))
          ],
        ),
      ): 
      
      
      
      
      
      
      
      datas.length == 0
            ? Center(
        child: FlareActor(
          'assets/images/ipe.flr',
          animation : 'loading',
          color: Colors.deepPurpleAccent,
          alignment: Alignment.center,
          fit: BoxFit.contain,

        
        
        
        ),
      ):
      
      
      
      ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
        return  
            
             Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0)
              ),
              child: Container(
                height: 100,
                alignment: Alignment.center,
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Text(datas[index].name,style: textStyleBold,),
                  subtitle: Text(datas[index].title,style: textStyle1,),
                  trailing: IconButton(icon: Icon(Icons.call), onPressed: () {
                    datas[index].phone.length != 11
                                ? Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('Phone number is not available!'),
                                  ))
                                : launch("tel:${datas[index].phone}");
                  },),
                ),
              ),
            );
          
        
       },
      )
    );
  }
}

