import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:ipe_family/home.dart';
import 'package:ipe_family/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  var counter = 0;
  var code;

  var formKey = GlobalKey<FormState>();
  var codeCtrl = TextEditingController();
  var textStyle = TextStyle(
    fontFamily: "Raleway",
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  var textStyle1 = TextStyle(
    fontFamily: "Raleway",
    fontWeight: FontWeight.w600,
  );

  void handleSubmit() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      sp.setInt('counter', 1);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SplashPage()));
    }
  }

  check() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    //sp.setInt('counter', 0);
    int c = (sp.getInt('counter') ?? 0);

    if (c == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  // checkInternet() async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.none) {
  //     print('not connected');
  //   } else {
  //     print('connected');
  //   }
  // }

  @override
  void initState() {
    check();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 0,
          ),
          Hero(
          tag: 'splash',
          child: Container(
            height: 120,
            width: 200,
            alignment: Alignment.center,
            child: FlareActor(
              
              'assets/images/ipe.flr',
              animation : 'loading',
              color: Colors.deepPurpleAccent,
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,


            
            
            
            ),
          ),
        ),
          Text(
            'Wellcome to',
            style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 20,
                fontWeight: FontWeight.w300),
          ),
          Text(
            'SUST IPE Family',
            style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 28,
                fontWeight: FontWeight.w700),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Text(
              'This app is only for the members of IPE Department,SUST. If you are not one of them, you may leave.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: TextFormField(
                  controller: codeCtrl,
                  style: textStyle,
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(5)),
                    hintText: "Enter IPE Secret Code",
                    hintStyle: textStyle1,

                    labelText: "Code",
                    labelStyle: textStyle,
                    alignLabelWithHint: true,
                    //prefixIcon: Icon(Icons.account_circle),
                  ),
                  //controller: nameCtrl,
                  keyboardType: TextInputType.number,

                  maxLength: 3,

                  validator: (value) {
                    var val = '334';
                    if (value.length == 0)
                      return ("Code can't be empty!");
                    else if (value != val)
                      return ("Wrong Code! Please try again.");

                    return value = null;
                  },
                  onSaved: (value) {
                    this.code = value;
                  }),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 45,
            width: 150,
            child: FlatButton(
              
              color: Colors.deepPurpleAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              child: Text(
                "Submit",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w600),
              ),
              onPressed: () {
                handleSubmit();
                
              },
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Text(
              'Hint : This code contains 3 digits & this is required for security purposes only. (Enter 5th, 6th & 7th digits of your registration number). ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          
          
        ],
      )),
    );
  }
}
