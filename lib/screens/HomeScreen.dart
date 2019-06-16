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
import 'ChartScreen.dart';
import 'PromoScreen.dart';
import 'SettingScreen.dart';
import 'package:papyrus_client/helpers/LongButton.dart';
import 'EditReceiptScreen.dart';
import 'ShowQRScreen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:papyrus_client/models/AppModel.dart';
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
        model: AppModel(),
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
            // fon
            fontFamily: 'Montserrat',

            primarySwatch: Colors.blue,
          ),
          home: SplashScreen(),
          // FutureBuilder(
          //     future: appModel.mAuth.currentUser(),
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.done) {
          //         if (snapshot.data != null)
          //           return HomeScreen();
          //         else
          //           return LogInScreen();
          //       } else
          //         return Container(
          //             width: MediaQuery.of(context).size.width,
          //             height: MediaQuery.of(context).size.height,
          //             color: Colors.red,
          //             child: Stack(
          //               children: <Widget>[
          //                 LogInScreen(),
          //                 Container(
          //                   color: Colors.black12,
          //                   width: MediaQuery.of(context).size.width,
          //                   height: MediaQuery.of(context).size.height,
          //                   child: Center(
          //                     child: CircularProgressIndicator(),
          //                   ),
          //                 )
          //               ],
          //             ));
          //     });
          // }),
          // routes: <String, WidgetBuilder>{
          //   '/': (context) =>HomeScreen(),
          // },
        ));
  }
}

// loadUser()async{
//   await appModel.user;

// }
double homeButtonDist;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      // #61C350
    ));
    return Scaffold(
      // bottomNavigationBar: CustomAppBar(),
      // appBar: AppBar(),
      // body: SingleChildScrollView(
      body: Column(
        children: <Widget>[HomeScreenTopPart(), HomeScreenBottomPart()],
      ),
      // ),
    );
  }
}

class HomeScreenTopPart extends StatefulWidget {
  @override
  _HomeScreenTopPartState createState() => new _HomeScreenTopPartState();
}

class _HomeScreenTopPartState extends State<HomeScreenTopPart> {
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
    TextStyle headerStyle = TextStyle(
        fontSize: sizeMulH * 20,
        fontWeight: FontWeight.w500,
        color: Colors.white);

    TextStyle headerStyleSelected = TextStyle(
        fontSize: sizeMulW * 20.57,
        fontWeight: FontWeight.bold,
        color: Colors.green[700]);

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
                maxHeight: MediaQuery.of(context).size.width * 0.91),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 0.942 * MediaQuery.of(context).size.width,
              child: Material(
                color: Colors.white.withAlpha(0),
                child: InkWell(
                  borderRadius:
                      BorderRadius.all(Radius.circular(15 * sizeMulW)),
                  onTap: () {},
                  splashColor: Colors.green,
                  highlightColor: greeny.colors[0],
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height:71 * sizeMulH,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width * 0.05,
                          // ),
                          // SizedBox(
                          //   width: 20.57 * sizeMulW,
                          // ),
                          RaisedButton(
                            highlightElevation: 0,
                            color: Colors.white.withOpacity(0),
                            elevation: 0,
                            splashColor: Colors.white.withAlpha(0),
                            highlightColor: Colors.black.withOpacity(0),
                            onPressed: () {
                              appModel.viewing_period = Period.MONTHLY;
                            },
                            child: Container(
                              // margin: EdgeInsets.all((sizeMulH*15)),
                              // color: Colors.white,
                              padding:
                                  (appModel.viewing_period == Period.MONTHLY)
                                      ? EdgeInsets.symmetric(
                                          vertical: sizeMulW * 2,
                                          horizontal: sizeMulW * 8)
                                      : null,
                              decoration: (appModel.viewing_period ==
                                      Period.MONTHLY)
                                  ? BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(sizeMulW * 300))
                                  : null,

                              child: Text("MONTHLY",
                                  style: (appModel.viewing_period ==
                                          Period.MONTHLY)
                                      ? headerStyleSelected
                                      : headerStyle),
                            ),
                          ),
                          RaisedButton(
                            splashColor: Colors.white.withAlpha(0),
                            elevation: 0,
                            color: Colors.white.withAlpha(0),
                            highlightElevation: 0,
                            highlightColor: Colors.black.withOpacity(0),
                            onPressed: () {
                              appModel.viewing_period = Period.WEEKLY;

                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          ReceiveReceiptScreen(
                                              appModel.receiveReceiptModel)));
                            },
                            child: Container(
                              padding:
                                  (appModel.viewing_period == Period.WEEKLY)
                                      ? EdgeInsets.symmetric(
                                          vertical: sizeMulW * 2,
                                          horizontal: sizeMulW * 8)
                                      : null,
                              decoration: (appModel.viewing_period ==
                                      Period.WEEKLY)
                                  ? BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(sizeMulW * 300))
                                  : null,
                              child: Text(
                                "WEEKLY",
                                style:
                                    (appModel.viewing_period == Period.WEEKLY)
                                        ? headerStyleSelected
                                        : headerStyle,
                              ),
                            ),
                          ),
                          RaisedButton(
                            splashColor: Colors.white.withAlpha(0),
                            elevation: 0,
                            highlightElevation: 0,
                            color: Colors.white.withAlpha(0),
                            highlightColor: Colors.black.withOpacity(0),
                            onPressed: () {
                              appModel.viewing_period = Period.DAILY;
                            },
                            child: Container(
                              padding: (appModel.viewing_period == Period.DAILY)
                                  ? EdgeInsets.symmetric(
                                      vertical: sizeMulW * 2,
                                      horizontal: sizeMulW * 8)
                                  : null,
                              decoration: (appModel.viewing_period ==
                                      Period.DAILY)
                                  ? BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(sizeMulW * 300))
                                  : null,
                              child: Text(
                                "DAILY",
                                style: (appModel.viewing_period == Period.DAILY)
                                    ? headerStyleSelected
                                    : headerStyle,
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width * 0.05,
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.07,
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "TOTAL SPENT",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.042,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                                Material(
                                  color: Colors.white.withOpacity(0),
                                  child: InkWell(
                                    splashColor: Colors.white.withAlpha(0),
                                    highlightColor:
                                        Colors.black.withOpacity(0.1),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  ShowQRScreen()));
                                    },
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(3000)),
                                    child: Icon(
                                      Icons.keyboard_arrow_down,
                                      // FontAwesomeIcons.dollarSign,
                                      color: Colors.white,
                                      size: MediaQuery.of(context).size.width *
                                          0.05,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 7 * sizeMulW,
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
                                  MediaQuery.of(context).size.width * 0.042),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("${addCommas(4231)}.",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.09,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white)),

                                  Container(
                                    padding:
                                        EdgeInsets.only(bottom: 4 * sizeMulW),
                                    child: Text("75 ",
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  ),
                                  // ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(15 * sizeMulW)),
                                  border: Border.all(
                                      color: Colors.white,
                                      width: MediaQuery.of(context).size.width *
                                          0.005)),
                            ),
                          ),
                        ),
                      ),

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
            top: 20,
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
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => PromoScreen()));
                          },
                          // highlightColor: Colors.black,
                          child: Stack(
                            children: <Widget>[
                              Icon(
                                // Icons.local_offer,
                                // FontAwesomeIcons.bell,
                                Icons.notifications,
                                size: MediaQuery.of(context).size.width * 0.11,
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
                              Positioned(
                                top: 14 * sizeMulW,
                                right: 5 * sizeMulW,
                                child: Container(
                                  width: sizeMulW * 20,
                                  height: sizeMulW * 20,
                                  child: Center(
                                    child: Text(
                                      "12",
                                      style: TextStyle(
                                          fontSize: 12 * sizeMulW,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(3000))),
                                ),
                              )
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
                              builder: (context) => ChartScreen()));
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
                    Icons.add,
                    // FontAwesomeIcons.plus,
                    size: sizeMulW * 41.14,
                    // size: sizeMulW*30,
                    color: Colors.white,
                  ),
                )),
          )
        ],
      );
    });
  }
}

class HomeScreenBottomPart extends StatefulWidget {
  @override
  _HomeScreenBottomPartState createState() => new _HomeScreenBottomPartState();
}

class _HomeScreenBottomPartState extends State<HomeScreenBottomPart> {
  goToReceiptsScreen() {}

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(builder: (context, child, appModel) {
      return new Container(
        // constraints: BoxConstraints(
        //   minHeight: MediaQuery.of(context).size.height -
        //     0.942 * MediaQuery.of(context).size.width,
        //     minWidth:  MediaQuery.of(context).size.width,
        // ),
        // color: Colors.black26,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height -
            0.942 * MediaQuery.of(context).size.width,
        color: Colors.white.withAlpha(0),
        padding: EdgeInsets.symmetric(horizontal: sizeMulW * 35),
        child: Center(
          // mainAxisAlignment: MainAxisAlignment.center,
          // children: <Widget>[
          child:
              // SizedBox(width: 30 * MediaQuery.of(context).size.width / 400),
              Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      (34 * sizeMulW),
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.red,
                  child: FutureBuilder(
                      future: bottomChildren(appModel, context),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.active)
                          return CircularProgressIndicator();
                        // return Container(
                        //   // width: MediaQuery.of(context).size.width,
                        //   // height: 300,
                        //   child: Shimmer.fromColors(
                        //     baseColor: Colors.grey[200],
                        //     highlightColor: Colors.white,
                        //     child: Column(
                        //       mainAxisSize: MainAxisSize.max,
                        //       mainAxisAlignment:
                        //           MainAxisAlignment.spaceEvenly,
                        //       children: List<int>.generate(
                        //               ((MediaQuery.of(context).size.height -
                        //                           0.942 *
                        //                               MediaQuery.of(context)
                        //                                   .size
                        //                                   .width -
                        //                           (34 * sizeMulW)) /
                        //                       (81 * sizeMulW))
                        //                   .floor(),
                        //               (i) => i)
                        //           .toList()
                        //           .map((f) => Container(
                        //                 width: 333 * sizeMulW,
                        //                 height: 72 * sizeMulW,
                        //                 decoration: BoxDecoration(
                        //                     color: Colors.green,
                        //                     // border: Border.all(
                        //                     //     color: Colors.red,
                        //                     //     width: 1 * sizeMulW),
                        //                     // boxShadow: [
                        //                     //   new BoxShadow(
                        //                     //     blurRadius: 2 * sizeMulW,
                        //                     //     color: Colors.black12,
                        //                     //     offset: new Offset(
                        //                     //         0, 0.4 * sizeMulW),
                        //                     //   ),
                        //                     // ],
                        //                     borderRadius: BorderRadius.all(
                        //                         Radius.circular(
                        //                             9 * sizeMulW))),
                        //               ))
                        //           .toList(),
                        //     ),
                        //   ),
                        // );
                        else {
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: snapshot.data,
                          );
                        }
                      }))

              // ReceiptCard("May 19, 2019", 99, "mainItem", "imagePath"),
            ],
          ),
          // SizedBox(width: 30 * MediaQuery.of(context).size.width / 400),
          // ],
        ),
      );
    });
  }
}

String addCommas(int nums) {
  return nums.toString().replaceAllMapped(
      new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
}

Future<List<Widget>> bottomChildren(
    AppModel appModel, BuildContext context) async {
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

  return bc;
}
