import 'package:flutter/material.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
      ),
    );
  }
}