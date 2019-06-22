import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:papyrus_client/helpers/ClipShadowPath.dart';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:papyrus_client/helpers/ReceiptCard.dart';
import 'package:shimmer/shimmer.dart';
// import 'receipts_page.dart';
import 'package:papyrus_client/helpers/ScrollBehaviour.dart';
import 'package:papyrus_client/helpers/CustomShapeClipper.dart';
import 'package:papyrus_client/screens/ReceiptScreen.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'ChartScreen.dart';
import 'PromoScreen.dart'; 
import 'SettingScreen.dart';
import 'package:papyrus_client/helpers/CustomShowDialog.dart';
import 'package:papyrus_client/helpers/LongButton.dart';
import 'EditReceiptScreen.dart';
import 'ShowQRScreen.dart';
import 'ChatScreen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:papyrus_client/models/AppModel.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:papyrus_client/screens/LogInScreen.dart';
import 'SplashScreen.dart';
import 'CameraCaptureScreen.dart';
import 'GetReceiptScreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'ReceiveReceiptScreen.dart';
import 'package:papyrus_client/data_models/Receipt.dart';
import 'package:papyrus_client/data_models/UserExpense.dart';
import 'dart:convert';
import 'dart:io';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import 'dart:core';
import 'package:papyrus_client/helpers/CustomIcons.dart';

// void main() {
//   return runApp(PapyrusCustomer());
// }
double sizeMulW = 0;
double sizeMulH = 0;
double recptCardHeight = 0;
LinearGradient greeny = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    const Color(0xFF6DC739),
    // Colors.green[300],
    const Color(0xFF1BA977),
  ],
  tileMode: TileMode.repeated,
);
LinearGradient BtnTeal = LinearGradient(
  begin: Alignment.centerRight,
  end: Alignment.centerLeft,
  colors: [
    const Color(0xFF40A1A8),
    const Color(0xFF52C5A4),
    const Color(0xFF63DCA0),
  ],
  tileMode: TileMode.repeated,
);

class PapyrusCustomer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
        model: AppModel(context),
        child: MaterialApp(
          builder: (context, child) {
            return ScrollConfiguration(
              behavior: CustomScrollBehaviour(),
              child: child,
            );
          },
          // initialRoute: '/',

          debugShowCheckedModeBanner: false,
          title: 'Papyrus - Expense Management',
          theme: ThemeData(
            // primaryColorDark: const Color(0xFF61C350),
            // fon
            fontFamily: 'Montserrat',

            primarySwatch: Colors.lightGreen,
          ),
          home: SplashScreen(),
     
        ));
  }
}

// loadUser()async{
//   await appModel.user;

// }
double homeButtonDist;

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  Size get preferredSize => Size(0.0, 0.0);
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int currentPage = 1;
  // var ShapeBorder s = new ShapeBorder();

  @override
  Widget build(BuildContext context) {
    sizeMulW = MediaQuery.of(context).size.width / 411.4;
    sizeMulH = MediaQuery.of(context).size.height / 683;
    recptCardHeight = 72 * sizeMulW;
    homeButtonDist = -0.00023 *
            (MediaQuery.of(context).size.width *
                MediaQuery.of(context).size.width) +
        0.9466 * (MediaQuery.of(context).size.width) -
        56.372;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: const Color(0xFF61C350),
      systemNavigationBarColor: const Color(0xFF1BA977),
      // #61C350
    ));

    return Scaffold(
      // bottomNavigationBar: CustomAppBar(),
      appBar: EmptyAppBar(),
      // body: SingleChildScrollView(
      primary: true,

      body:
          ScopedModelDescendant<AppModel>(builder: (context, child, appModel) {
        return SimpleGestureDetector(
          onHorizontalSwipe: (dir) {
            print("dragged");

            if (dir == SwipeDirection.left) {
              print("swipedrr");
              if (appModel.viewing_period == Period.MONTHLY)
                appModel.viewing_period = Period.WEEKLY;
              else if (appModel.viewing_period == Period.WEEKLY)
                appModel.viewing_period = Period.DAILY;
            } else if (dir == SwipeDirection.right) {
              print("swipedrr");
              if (appModel.viewing_period == Period.DAILY)
                appModel.viewing_period = Period.WEEKLY;
              else if (appModel.viewing_period == Period.WEEKLY)
                appModel.viewing_period = Period.MONTHLY;
            }
          },
          child:  Column(
                children: <Widget>[
                  HomeScreenTopPart(  this),  HomeScreenBottomPart( this) 
                ],
              ) 
            
        );
      }),
      // ),
    );
  }
}

class HomeScreenTopPart extends StatefulWidget {
 
  _HomeScreenState parent;
  HomeScreenTopPart(  this.parent);
  @override
  _HomeScreenTopPartState createState() => new _HomeScreenTopPartState(  parent);
}

class _HomeScreenTopPartState extends State<HomeScreenTopPart> {

  
   
  _HomeScreenState parent;
  _HomeScreenTopPartState(  this.parent);
  static const platform = const MethodChannel('flutter.native/helper');
  String _responseFromNativeCode = 'Waiting for Response...';
  Future<void> responseFromNativeCode() async {
    String response = "";
    try {
      final String result =
          await platform.invokeMethod('helloFromNativeCode', "sdf");
      response = result;
    } on PlatformException catch (e) {
      response = "Failed to Invoke: '${e.message}'.";
    }
    // setState(() {
    //   _responseFromNativeCode = response;
    // });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle headerStyle = TextStyle(fontSize: 17.4, color: Colors.white);

    TextStyle headerStyleSelected = TextStyle(
        fontSize: 18.4, fontWeight: FontWeight.bold, color: Colors.green[700]);

    return ScopedModelDescendant<AppModel>(builder: (context, child, appModel) {
      return Stack(
        children: <Widget>[
          ClipShadowPath(
            shadow: Shadow(
                blurRadius: 10 * sizeMulW,
                offset: Offset(0, sizeMulW),
                color: Colors.black38),
            clipper: CustomShapeClipper(
                sizeMulW: sizeMulW,
                maxWidth: MediaQuery.of(context).size.width,
                maxHeight:
                    MediaQuery.of(context).size.width * 0.91 - (24 * sizeMulW)),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 0.942 * MediaQuery.of(context).size.width - 24 * sizeMulW,
              child: Material(
                color: Colors.white.withAlpha(0),
                child: InkWell(
                  borderRadius:
                      BorderRadius.all(Radius.circular(15 * sizeMulW)),
                  onTap: () {},
                  splashColor: Colors.green,
                  highlightColor: greeny.colors[0],
                  child: Stack(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.max,

                    children: <Widget>[
                      // SizedBox(
                      //   height: 71 * sizeMulW,
                      // ),
                      Positioned(
                        left: 0,
                        right: 0,
                        top: MediaQuery.of(context).size.width * 0.91 * 0.16,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            // SizedBox(
                            //   width: MediaQuery.of(context).size.width * 0.05,
                            // ),
                            // SizedBox(
                            //   width: 20.57 * sizeMulW,
                            // ),
                            Container(
                              // width: sizeMulW * 130,
                              // height: sizeMulH * 30,
                              child: Center(
                                child: InkWell(
                                  // highlightElevation: 0,
                                  // color: Colors.white.withOpacity(0),
                                  // elevation: 0,
                                  splashColor: Colors.white.withAlpha(0),
                                  highlightColor: Colors.black.withOpacity(0),

                                  onTap: () {
                                    appModel.viewing_period = Period.MONTHLY;
                                  },
                                  child: Container(
                                    // margin: EdgeInsets.all((sizeMulH*15)),
                                    // color: Colors.white,
                                    // width: sizeMulW*20,
                                    // height: sizeMulH*0.2,
                                    padding: (appModel.viewing_period ==
                                            Period.MONTHLY)
                                        ? EdgeInsets.symmetric(
                                            vertical: sizeMulW * 2,
                                            horizontal: sizeMulW * 8)
                                        : null,
                                    decoration: (appModel.viewing_period ==
                                            Period.MONTHLY)
                                        ? BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                sizeMulW * 300))
                                        : null,

                                    child: Text("MONTHLY",
                                        style: (appModel.viewing_period ==
                                                Period.MONTHLY)
                                            ? headerStyleSelected
                                            : headerStyle),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              // width: sizeMulW * 130,
                              // height: sizeMulH * 30,
                              child: Center(
                                child: InkWell(
                                  splashColor: Colors.white.withAlpha(0),
                                  // elevation: 0,
                                  // color: Colors.white.withAlpha(0),
                                  // highlightElevation: 0,
                                  highlightColor: Colors.black.withOpacity(0),
                                  onTap: () {
                                    appModel.viewing_period = Period.WEEKLY;

                                    // Navigator.push(
                                    //     context,
                                    //     CupertinoPageRoute(
                                    //         builder: (context) =>
                                    //             ReceiveReceiptScreen(
                                    //                 appModel.receiveReceiptModel)));
                                  },
                                  child: Container(
                                    padding: (appModel.viewing_period ==
                                            Period.WEEKLY)
                                        ? EdgeInsets.symmetric(
                                            vertical: sizeMulW * 2,
                                            horizontal: sizeMulW * 8)
                                        : null,
                                    decoration: (appModel.viewing_period ==
                                            Period.WEEKLY)
                                        ? BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                sizeMulW * 300))
                                        : null,
                                    child: Text(
                                      "WEEKLY",
                                      style: (appModel.viewing_period ==
                                              Period.WEEKLY)
                                          ? headerStyleSelected
                                          : headerStyle,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              // width: sizeMulW * 110,
                              // height: sizeMulH * 30,
                              child: Center(
                                child: InkWell(
                                  splashColor: Colors.white.withAlpha(0),
                                  // elevation: 0,
                                  // highlightElevation: 0,
                                  // color: Colors.white.withAlpha(0),
                                  highlightColor: Colors.black.withOpacity(0),
                                  onTap: () {
                                    appModel.viewing_period = Period.DAILY;
                                  },
                                  child: Container(
                                    padding: (appModel.viewing_period ==
                                            Period.DAILY)
                                        ? EdgeInsets.symmetric(
                                            vertical: sizeMulW * 2,
                                            horizontal: sizeMulW * 8)
                                        : null,
                                    decoration: (appModel.viewing_period ==
                                            Period.DAILY)
                                        ? BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                sizeMulW * 300))
                                        : null,
                                    child: Text(
                                      "DAILY",
                                      style: (appModel.viewing_period ==
                                              Period.DAILY)
                                          ? headerStyleSelected
                                          : headerStyle,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   width: MediaQuery.of(context).size.width * 0.05,
                            // ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.width * 0.07,
                      // ),
                      Center(
                        // left: 0,
                        // right: 0,
                        // top: MediaQuery.of(context).size.width * 0.91 * 0.3,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "TOTAL SPENT",
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.042,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                      Material(
                                        color: Colors.white.withOpacity(0),
                                        child: InkWell(
                                          splashColor:
                                              Colors.white.withAlpha(0),
                                          highlightColor:
                                              Colors.black.withOpacity(0.1),
                                          onTap: () {
                                            // Navigator.push(
                                            //     context,
                                            //     CupertinoPageRoute(
                                            //         builder: (context) =>
                                            //             ShowQRScreen()));
                                          },
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(3000)),
                                          child: Icon(
                                            (appModel.loadedUserExpense)
                                                ? chevronTicker(appModel)
                                                : Icons.keyboard_arrow_up,
                                            // FontAwesomeIcons.dollarSign,
                                            color: Colors.white,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ConstrainedBox(
                                    constraints: new BoxConstraints(
                                      // minHeight: 100*sizeMulW,
                                      minWidth: 160 * sizeMulW,

                                      // maxHeight: 30.0,
                                      // maxWidth: 30.0,
                                    ),
                                    child: Material(
                                      // shape: CircleBorder(),
                                      color: Colors.white.withAlpha(0),
                                      child: InkWell(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15 * sizeMulW)),
                                        onTap: () {
                                          // print(result);
                                        },
                                        splashColor: Colors.greenAccent,
                                        highlightColor: Colors.green,
                                        child: Container(
                                          // height: sizeMulW * 80,
                                          padding: EdgeInsets.all(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.042),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              (appModel.loadedUserExpense)
                                                  ? Text(
                                                      ((appModel.viewing_period == Period.DAILY && appModel.loadedUserExpense) ? addCommas(int.parse(appModel.dayExpense.totalSpent.toStringAsFixed(2).split('.')[0])) : (appModel.viewing_period == Period.MONTHLY && appModel.loadedUserExpense) ? addCommas(int.parse(appModel.monthExpense.totalSpent.toStringAsFixed(2).split('.')[0])) : (appModel.viewing_period == Period.WEEKLY && appModel.loadedUserExpense) ? addCommas(int.parse(appModel.weekExpense.totalSpent.toStringAsFixed(2).split('.')[0])) : "0") +
                                                          ".",
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.09,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.white))
                                                  : Text("0 ",
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.09,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.white)),

                                              (appModel.loadedUserExpense)
                                                  ? Container(
                                                      padding: EdgeInsets.only(
                                                          bottom: 4 * sizeMulW),
                                                      child: Text(
                                                          decimalDigits(
                                                              appModel),
                                                          style: TextStyle(
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.05,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .white)),
                                                    )
                                                  : Container(
                                                      padding: EdgeInsets.only(
                                                          bottom: 4 * sizeMulW),
                                                      child: Text("00",
                                                          style: TextStyle(
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.05,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .white)),
                                                    ),
                                              // ),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      15 * sizeMulW)),
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.005)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: 7 * sizeMulW,
                      // ),

                      // Container(margin: EdgeIns,)
                    ],
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.red,
                gradient: greeny,
//                LinearGradient(
//   begin: Alignment.topCenter,

//   end: Alignment.bottomCenter,
//   colors: [
//     const Color(0xFF6DC749),
//     const Color(0xFF1BA977),
//     const Color(0xFF1BA9BB),
//   ],
//   tileMode: TileMode.repeated,
// )
                //  LinearGradient(
                //   begin: Alignment.topCenter,
                //   end: Alignment.bottomCenter,
                //   colors: [
                //     const Color(0xFF61C34F),
                //     const Color(0xFF20AB50),
                //     // const Color(0xFF61C350),
                //     // // const Color(0x1BA9774),
                //     // const Color.fromARGB(255, 27, 169, 119)
                //   ],
                //   tileMode: TileMode.repeated,
                // ),
              ),

              // color: Colors.red,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        width: 20 * sizeMulW,
                      ),
                      Material(
                        color: Colors.white.withOpacity(0),
                        borderRadius: BorderRadius.all(Radius.circular(3000)),
                        child: InkWell(
                          radius: sizeMulW * 4,
                          splashColor: Colors.white.withAlpha(0),
                          highlightColor: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.all(Radius.circular(3000)),
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => SettingScreen()));
                          },
                          child: Icon(
                            Icons.more_horiz,

                            // CustomIcons.menu,
                            // FontAwesomeIcons.ellipsisV,
                            // FontAwesomeIcons.bars,
                            // Icons.settings,
                            size: MediaQuery.of(context).size.width * 0.11,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Material(
                        color: Colors.white.withOpacity(0),
                        borderRadius: BorderRadius.all(Radius.circular(3000)),
                        child: InkWell(
                          splashColor: Colors.white.withAlpha(0),
                          highlightColor: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.all(Radius.circular(3000)),
                          radius: sizeMulW * 45,
                          onTap: () {
                            showChat(context, appModel);
                            // Navigator.push(
                            //     context,
                            //     CupertinoPageRoute(
                            //         builder: (context) => PromoScreen()));
                          },
                          // highlightColor: Colors.black,
                          child: Stack(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  showChat(context, appModel);
                                  // Navigator.push(
                                  //     context,
                                  //     CupertinoPageRoute(
                                  //         builder: (context) => PromoScreen()));
                                },
                                child: SizedBox(
                                  width: sizeMulW * 45,
                                  height: sizeMulW * 45,
                                ),
                              ),
                              Icon(
                                // Icons.local_offer,
                                // FontAwesomeIcons.bell,
                                // Icons.notifications,
                                FontAwesomeIcons.robot,
                                size: sizeMulW * 30,
                                color: Colors.white,
                              ),
                              // Positioned()
                              // Container(
                              //   margin: EdgeInsets.all(sizeMulW*2),
                              //   child: Image.asset(
                              //     'assets/icons/3x/bell.png',
                              //     height:
                              //         MediaQuery.of(context).size.width * 0.1,
                              //   ),
                              // ),
                              // Positioned(
                              //   top: 14 * sizeMulW,
                              //   right: 5 * sizeMulW,
                              //   child: Container(
                              //     width: sizeMulW * 20,
                              //     height: sizeMulW * 20,
                              //     child: Center(
                              //       child: Text(
                              //         "12",
                              //         style: TextStyle(
                              //             fontSize: 12 * sizeMulW,
                              //             color: Colors.white,
                              //             fontWeight: FontWeight.w900),
                              //       ),
                              //     ),
                              //     decoration: BoxDecoration(
                              //         color: Colors.red,
                              //         borderRadius: BorderRadius.all(
                              //             Radius.circular(3000))),
                              //   ),
                              // )
                            ],
                          ),

                          // Icon(
                          //   Icons.notifications,
                          //   size: MediaQuery.of(context).size.width * 0.10,
                          //   color: Colors.white,
                          // ),
                        ),
                      ),
                      SizedBox(
                        width: 20 * sizeMulW,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.05,
            bottom: MediaQuery.of(context).size.width * 0.13,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Container(
                // width: MediaQuery.of(context).size.width * 0.2,
                // height: MediaQuery.of(context).size.width * 0.2,
                child: Material(
                  color: Colors.white.withOpacity(0),
                  borderRadius: BorderRadius.all(Radius.circular(3000)),
                  child: InkWell(
                    radius: sizeMulW * 51,
                    splashColor: Colors.white.withAlpha(0),
                    highlightColor: Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.all(Radius.circular(3000)),
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                                  ChartScreen(appModel.chartsScreenModel)));
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.chartPie,
                          size: MediaQuery.of(context).size.width * 0.088,
                          color: Colors.white,
                        ),
                        // Image.asset(
                        //   'assets/icons/charts.png',
                        //   height: MediaQuery.of(context).size.width * 0.098,
                        // ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.015,
                        ),
                        Text(
                          "Charts",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // SliverAppBar(

          // )
          Positioned(
            bottom: 3 * sizeMulH,
            // right: MediaQuery.of(context).size.width * 0.035,
            // left: ( MediaQuery.of(context).size.height/ MediaQuery.of(context).size.width)*102,
            // left:128,
            left: homeButtonDist,
            // left: -0.0002*(MediaQuery.of(context).size.width*MediaQuery.of(context).size.width) + 0.8991*(MediaQuery.of(context).size.width) - 49.764,
            // left: 0.776*MediaQuery.of(context).size.width - 30.378,
            child: RaisedButton(
                splashColor: greeny.colors[0],
                animationDuration: Duration(milliseconds: 100),
                shape: CircleBorder(),
                elevation: 5,
                color: greeny.colors[1],
                onPressed: () {
                  print("SIIZE" + MediaQuery.of(context).size.toString());
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) {
                    return
                        // EditReceiptScreen(appModel.editReceiptScreenModel)
                        // CameraCaptureScreen()
                        GetReceiptScreen(appModel.cameraCaptureModel);
                  }));
                },
                child: Container(
                  width: (0.5 * (sizeMulW + sizeMulH)) * 74.052,
                  height: (0.5 * (sizeMulW + sizeMulH)) * 74.052,
                  child: Icon(
                    // print(size);
                    // Icons.add,
                    FontAwesomeIcons.plus,
                    size: sizeMulW * 33,
                    // size: sizeMulW*30,
                    color: Colors.white,
                  ),
                )),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(child:  DotsIndicator(
                dotsCount: 3,
                position: parent.currentPage,
                decorator: DotsDecorator(
                  activeColor: Colors.green,
                  size: const Size.square(12.0),
                  activeSize: const Size(24, 12.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
              ) 
            ),
          )
        ],
      );
    });
  }
}

class HomeScreenBottomPart extends StatefulWidget {

  _HomeScreenState parent; 
  HomeScreenBottomPart(  this.parent);
  @override
  _HomeScreenBottomPartState createState() =>
      new _HomeScreenBottomPartState(  parent);
}

 

class _HomeScreenBottomPartState extends State<HomeScreenBottomPart>
    with SingleTickerProviderStateMixin {
  _HomeScreenState parent; 
  _HomeScreenBottomPartState(  this.parent);
  goToReceiptsScreen() {}
  TabController tabController;

  void _handleTabSelection() {
    print("TAAAAAAAAAAABSS" + tabController.index.toString()); 
    parent. setState(() {
      parent.currentPage = tabController.index;
      
          
        });
    
  }

  @override
  void initState() {
   
    // TODO: implement initState
    super.initState();
    tabController = TabController(
      length: 3,
      vsync: this,
    );

    tabController.addListener(_handleTabSelection);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(builder: (context, child, appModel) {
      return Expanded(
        child: new Container(
          // constraints: BoxConstraints(
          //   minHeight: MediaQuery.of(context).size.height -
          //     0.942 * MediaQuery.of(context).size.width,
          //     minWidth:  MediaQuery.of(context).size.width,
          // ),
          // color: Colors.black26,
          width: MediaQuery.of(context).size.width,
          // height:

          // // double.infinity,

          //  MediaQuery.of(context).size.height -
          //     0.942 * MediaQuery.of(context).size.width -
          //     0
          //     ,
          color: Colors.white.withAlpha(0),
          child: Center(
            // mainAxisAlignment: MainAxisAlignment.center,
            // children: <Widget>[
            child:
                // SizedBox(width: 30 * MediaQuery.of(context).size.width / 400),
                DefaultTabController(
              length: 3,
              initialIndex: 1,
              child: TabBarView(
                controller: tabController,
                children: <Widget>[
                  Container(
                    color: Colors.blue,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: sizeMulW * 35),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "  Last Receipts",
                              style: TextStyle(
                                  fontSize: 26 * sizeMulW,
                                  color: Colors.black.withOpacity(0.8),
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: sizeMulW * 10,
                            ),
                            Icon(
                              FontAwesomeIcons.file,
                              size: MediaQuery.of(context).size.width * 0.062,
                              color: Colors.green,
                            )
                          ],
                        ),
                        // SizedBox(
                        //   height: sizeMulW * 1,
                        // ),
                        Container(
                          height: MediaQuery.of(context).size.height -
                              0.942 * MediaQuery.of(context).size.width -
                              24 * sizeMulW -
                              (34 * sizeMulW),
                          width: MediaQuery.of(context).size.width,
                          // color: Colors.red,

                          child: Flex(
                            direction: Axis.vertical,
                            children: (appModel.receiptsLoaded)
                                ? bottomChildren(appModel, context)
                                : [SizedBox(width: 1)],
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: (appModel.receiptsLoaded &&
                                    appModel.receiptFiles.length != 0)
                                ? MainAxisAlignment.spaceEvenly
                                : MainAxisAlignment.end,
                          ),
                        )
                        // child: FutureBuilder(
                        //     future: bottomChildren(appModel, context),
                        //     builder: (context, snapshot) {
                        //       if (snapshot.connectionState == ConnectionState.active)
                        //         return CircularProgressIndicator();
                        //       // return Container(
                        //       //   // width: MediaQuery.of(context).size.width,
                        //       //   // height: 300,
                        //       //   child: Shimmer.fromColors(
                        //       //     baseColor: Colors.grey[200],
                        //       //     highlightColor: Colors.white,
                        //       //     child: Column(
                        //       //       mainAxisSize: MainAxisSize.max,
                        //       //       mainAxisAlignment:
                        //       //           MainAxisAlignment.spaceEvenly,
                        //       //       children: List<int>.generate(
                        //       //               ((MediaQuery.of(context).size.height -
                        //       //                           0.942 *
                        //       //                               MediaQuery.of(context)
                        //       //                                   .size
                        //       //                                   .width -
                        //       //                           (34 * sizeMulW)) /
                        //       //                       (81 * sizeMulW))
                        //       //                   .floor(),
                        //       //               (i) => i)
                        //       //           .toList()
                        //       //           .map((f) => Container(
                        //       //                 width: 333 * sizeMulW,
                        //       //                 height: 72 * sizeMulW,
                        //       //                 decoration: BoxDecoration(
                        //       //                     color: Colors.green,
                        //       //                     // border: Border.all(
                        //       //                     //     color: Colors.red,
                        //       //                     //     width: 1 * sizeMulW),
                        //       //                     // boxShadow: [
                        //       //                     //   new BoxShadow(
                        //       //                     //     blurRadius: 2 * sizeMulW,
                        //       //                     //     color: Colors.black12,
                        //       //                     //     offset: new Offset(
                        //       //                     //         0, 0.4 * sizeMulW),
                        //       //                     //   ),
                        //       //                     // ],
                        //       //                     borderRadius: BorderRadius.all(
                        //       //                         Radius.circular(
                        //       //                             9 * sizeMulW))),
                        //       //               ))
                        //       //           .toList(),
                        //       //     ),
                        //       //   ),
                        //       // );
                        //       else if (snapshot.connectionState ==
                        //           ConnectionState.done) {
                        //         return Column(
                        //           mainAxisSize: MainAxisSize.max,
                        //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //           children: (snapshot.data.first != null)
                        //               ? snapshot.data
                        //               : [
                        //                   SizedBox(
                        //                     width: 1,
                        //                   )
                        //                 ],
                        //         );
                        //       } else
                        //         return Column(
                        //           mainAxisSize: MainAxisSize.max,
                        //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //           children: [
                        //             SizedBox(
                        //               width: 1,
                        //             )
                        //           ],
                        //         );
                        //     }))

                        // ReceiptCard("May 19, 2019", 99, "mainItem", "imagePath"),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.red,
                    height: 300,
                    width: 300,
                  )
                ],
              ),
            ),
            // SizedBox(width: 30 * MediaQuery.of(context).size.width / 400),
            // ],
          ),
        ),
      );
    });
  }
}

showChat(BuildContext context, AppModel appModel) {
  appModel.chatModel.init();
  showDialog(
      context: context,
      builder: (BuildContext context) {
        // return Container(width: MediaQuery.of(context).size.width,
        // height: double.infinity,
        // margin: EdgeInsets.all(50),
        // color: Colors.red,);
        return ChatScreen(appModel.chatModel);
      });
}

IconData chevronTicker(AppModel appModel) {
  if (appModel.viewing_period == Period.DAILY) {
    if (ExpenseAverages.lifetimeAverageDaySpend <
        appModel.dayExpense.totalSpent) return Icons.keyboard_arrow_up;
    return Icons.keyboard_arrow_down;
  } else if (appModel.viewing_period == Period.WEEKLY) {
    if (ExpenseAverages.lifetimeAverageWeekSpend <
        appModel.weekExpense.totalSpent) return Icons.keyboard_arrow_up;
    return Icons.keyboard_arrow_down;
  } else if (appModel.viewing_period == Period.MONTHLY) {
    if (ExpenseAverages.lifetimeAverageMonthSpend <
        appModel.monthExpense.totalSpent) return Icons.keyboard_arrow_up;
    return Icons.keyboard_arrow_down;
  }
}

String addCommas(int nums) {
  return nums.toString().replaceAllMapped(
      new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
}

String decimalDigits(AppModel appModel) {
  if (!appModel.loadedUserExpense) return "00";
  if (appModel.viewing_period == Period.DAILY) {
    if (((appModel.dayExpense.totalSpent).toStringAsFixed(2).split(".")[1]) ==
        "00") {
      return "00";
    }
    return (appModel.dayExpense.totalSpent).toStringAsFixed(2).split(".")[1];
  }

  if (appModel.viewing_period == Period.WEEKLY) {
    if (((appModel.weekExpense.totalSpent).toStringAsFixed(2).split(".")[1]) ==
        "00") {
      return "00";
    }
    return (appModel.weekExpense.totalSpent).toStringAsFixed(2).split(".")[1];
  }

  if (appModel.viewing_period == Period.MONTHLY) {
    if (((appModel.monthExpense.totalSpent).toStringAsFixed(2).split(".")[1]) ==
        "00") {
      return "00";
    }
    return (appModel.monthExpense.totalSpent).toStringAsFixed(2).split(".")[1];
  }
}

List<Widget> bottomChildren(AppModel appModel, BuildContext context) {
  List<Widget> bc = [
    LongButton(
      greeny.colors[1],
      333 * sizeMulW,
      69 * sizeMulW,
      sizeMulW * 3,
      Colors.green,
      greeny.colors[0],
      sizeMulW * 9,
      () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) =>
                    ReceiptScreen(appModel.receiptsScreenModel)));
      },
      Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "VIEW ALL",
              style: TextStyle(
                  color: Colors.white,
                  //
                  fontWeight: FontWeight.w900,
                  fontSize: sizeMulW * 20),
            ),
            SizedBox(
              width: sizeMulW * 5,
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.white,
              size: sizeMulW * 35,
            )
          ],
        ),
      ),
      // null
    )
  ];
  for (File f in appModel.receiptFiles) {
    Map map = jsonDecode(f.readAsStringSync());
    var receipt = Receipt.fromJson(map);
    if (appModel.receiptFiles.indexOf(f) <
        ((MediaQuery.of(context).size.height -
                        0.942 * MediaQuery.of(context).size.width -
                        (34 * sizeMulW)) /
                    (81 * sizeMulW))
                .floor() -
            1) {
      bc.insert(bc.length - 1, ReceiptCard(context, receipt, 1));
    } else
      break;

    //  else if (appModel.receipts.indexOf(f) ==
    //     ((MediaQuery.of(context).size.height -
    //                     0.942 * MediaQuery.of(context).size.width -
    //                     (34 * sizeMulW)) /
    //                 (81 * sizeMulW))
    //             .floor() -
    //         1) {
    //   // bc.add(

    //   // );
    // }
  }

  if (bc.length == 1) {
    bc.insert(
      0,
      Flexible(
        child: Container(
          padding: EdgeInsets.all(sizeMulH * 14),
          child: DottedBorder(
              color: Colors.black12,
              gap: 8 * sizeMulW,
              strokeWidth: 5 * sizeMulW,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: double.infinity,
                  child: RaisedButton(
                      onPressed: () {
                        Navigator.push(context,
                            CupertinoPageRoute(builder: (context) {
                          return GetReceiptScreen(appModel.cameraCaptureModel);
                        }));
                      },
                      highlightElevation: 0,
                      color: Colors.white.withOpacity(0),
                      elevation: 0,
                      splashColor: Colors.white.withAlpha(0),
                      highlightColor: Colors.white.withAlpha(0),
                      child: Center(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "NO RECEIPTS YET.\nTAP TO ADD",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: sizeMulW * 15),
                          ),
                          Icon(
                            FontAwesomeIcons.plusSquare,
                            size: sizeMulW * 30,
                            color: Colors.black12,
                          ),
                        ],
                      ))))

              // child: ,

              ),
        ),
      ),
    );
  }

  return bc;
}
