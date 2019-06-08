import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'package:papyrus_client/helpers/ClipShadowPath.dart';
import 'package:papyrus_client/helpers/CustomShapeClipper.dart';
import 'package:papyrus_client/helpers/LongButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:papyrus_client/models/AppModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'HomeScreen.dart';
import 'LogInScreen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration(milliseconds: 1300), () {
    //   Navigator.pushReplacement(
    //       context,
    //       CupertinoPageRoute(
    //           builder: (context) =>

    return ScopedModelDescendant<AppModel>(rebuildOnChange: false,builder: (context, child, appModel) {
      
      return FutureBuilder(
          future: 
          // Future.delayed(Duration(seconds: 3),(){}),
          appModel.mAuth.currentUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data != null)
                return HomeScreen();
              else
                return LogInScreen();
            } else if(snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.waiting)
                                       
              return SplashFrame();
          });
    });

    // ));
    // });
  }
}

class SplashFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.green,
        child: Center(
            child: Image.asset(
          'assets/icons/3x/papygreen.png',color: Colors.white,
          height: sizeMul * 100,
          width: sizeMul * 100,
        )),
      ),
    );
  }
}
