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
import 'package:toast/toast.dart';
import 'LogInScreen.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => new _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pages = [
    PageViewModel(
        // pageColor: const Color(0xFF03A9F4),
        pageColor: greeny.colors[1],
        // iconImageAssetPath: 'assets/air-hostess.png',
        // assets/icons/3x/burger_king.png
        bubble: Image.asset('assets/icons/3x/burger_king.png'),
        body: Text(
          'Gather all your receipts in one place and get rid of the unnecessary paper bulk',
        ),
        title: Container(height: 0,width: 100,color: Colors.red,),
       
        mainImage: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
                'Digital Receipts' ,
              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: sizeMulW*35),
                 
              ),
            Image.asset(
              'assets/icons/3x/digital_receipts.png',
              
              // fit: BoxFit.fitHeight,
              height: 240.0,
              width: 240.0,
              alignment: Alignment.center,
            ),
            SizedBox(height: 0.01,),
          ],
        )),
    PageViewModel(
        pageColor: greeny.colors[0],
      // pageColor: const Color(0xFF8BC34A),
      iconImageAssetPath: 'assets/icons/3x/burger_king.png',
      body: Text(
        "Track your expenses and save your hard-earned money",
      ),
      title: SizedBox(width:0.1),
      
        mainImage: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
                'Track Expenses' ,
              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: sizeMulW*35),
                 
              ),
            Image.asset(
              'assets/icons/3x/track.png',
              
              // fit: BoxFit.fitHeight,
              height: 220.0,
              width: 220.0,
              alignment: Alignment.center,
            ),
            SizedBox(height: 0.01,),
          ],
        ),
      // textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
    ),
    PageViewModel(
      
        pageColor: greeny.colors[1],
      // pageColor: const Color(0xFF607D8B),
      // iconImageAssetPath: 'assets/icons/3x/burger_king.png',
      body: Text(
        'Receive promos from partner stores tailored to your liking',
      ),
     
      title: SizedBox(width:0.1),
     
        mainImage: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
                'Great Deals' ,
              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: sizeMulW*35),
                 
              ),
            Image.asset(
              'assets/icons/3x/deals.png',
              
              // fit: BoxFit.fitHeight,
              height: 240.0,
              width: 240.0,
              alignment: Alignment.center,
            ),
            SizedBox(height: 0.01,),
          ],
        ),
      // textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
    ),
     PageViewModel(
       
        pageColor: greeny.colors[0],
      // pageColor: const Color(0xFF8BC34A),
      iconImageAssetPath: 'assets/icons/3x/burger_king.png',
      body: Text(
        "Instantly communicate to our partner stores through chat",
      ),
      
      title: SizedBox(width:0.1),
      
        mainImage: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
                'Communicate' ,
              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: sizeMulW*35),
                 
              ),
            Image.asset(
              'assets/icons/3x/telephone.png',
              // fit: BoxFit.fitHeight,
              height: 240.0,
              width: 240.0,
              alignment: Alignment.center,
            ),
            SizedBox(height: 0.01,),
          ],
        ),
      // textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return IntroViewsFlutter(
      pages,
      onTapDoneButton: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LogInScreen(),
          ), //MaterialPageRoute
        );
      },
      pageButtonTextStyles: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
      ),
    );
  }
}
