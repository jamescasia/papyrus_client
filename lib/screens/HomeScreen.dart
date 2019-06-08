import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:papyrus_client/helpers/ClipShadowPath.dart';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:papyrus_client/helpers/ReceiptCard.dart';
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
// void main() {
//   return runApp(PapyrusCustomer());
// }

double sizeMul = 0;
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
            fontFamily: 'Montserrat',
            primarySwatch: Colors.blue,
          ),
          home:  SplashScreen(),
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

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // var ShapeBorder s = new ShapeBorder();
  @override
  Widget build(BuildContext context) {
    sizeMul = MediaQuery.of(context).size.width / 411.4;
    recptCardHeight = 72 * sizeMul;
    print(MediaQuery.of(context).size);
    print(sizeMul);
    print(sizeMul * 12);
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
        fontSize: sizeMul * 18.513,
        fontWeight: FontWeight.normal,
        color: Colors.white);

    TextStyle headerStyleSelected = TextStyle(
        fontSize: sizeMul * 20.57,
        fontWeight: FontWeight.bold,
        color: Colors.green[700]);

    return ScopedModelDescendant<AppModel>(builder: (context, child, model) {
      return Stack(
        children: <Widget>[
          ClipShadowPath(
            shadow: Shadow(
                blurRadius: 10 * sizeMul,
                offset: Offset(0, sizeMul),
                color: Colors.black38),
            clipper: CustomShapeClipper(
                sizeMul: sizeMul,
                maxWidth: MediaQuery.of(context).size.width,
                maxHeight: MediaQuery.of(context).size.width * 0.91),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 0.942 * MediaQuery.of(context).size.width,
              child: Material(
                color: Colors.white.withAlpha(0),
                child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(15 * sizeMul)),
                  onTap: () {},
                  splashColor: Colors.green,
                  highlightColor: greeny.colors[0],
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 82.28 * sizeMul,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            width: 20.57 * sizeMul,
                          ),
                          InkWell(
                            splashColor: Colors.white.withAlpha(0),
                            highlightColor: Colors.black.withOpacity(0.1),
                            onTap: () {
                              model.viewing_period = Period.MONTHLY; 
                            },
                            child: Container(
                              // color: Colors.white,
                              padding: (model.viewing_period == Period.MONTHLY)
                                  ? EdgeInsets.symmetric(
                                      vertical: sizeMul * 2,
                                      horizontal: sizeMul * 8)
                                  : null,
                              decoration: (model.viewing_period ==
                                      Period.MONTHLY)
                                  ? BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(sizeMul * 300))
                                  : null,

                              child: Text("MONTHLY",
                                  style:
                                      (model.viewing_period == Period.MONTHLY)
                                          ? headerStyleSelected
                                          : headerStyle),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.white.withAlpha(0),
                            highlightColor: Colors.black.withOpacity(0.1),
                            onTap: () {
                              model.viewing_period = Period.WEEKLY;
                            },
                            child: Container(
                              padding: (model.viewing_period == Period.WEEKLY)
                                  ? EdgeInsets.symmetric(
                                      vertical: sizeMul * 2,
                                      horizontal: sizeMul * 8)
                                  : null,
                              decoration: (model.viewing_period ==
                                      Period.WEEKLY)
                                  ? BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(sizeMul * 300))
                                  : null,
                              child: InkWell(
                                splashColor: Colors.white.withAlpha(0),
                                highlightColor: Colors.black.withOpacity(0.1),
                                child: Text(
                                  "WEEKLY",
                                  style: (model.viewing_period == Period.WEEKLY)
                                      ? headerStyleSelected
                                      : headerStyle,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              model.viewing_period = Period.DAILY;
                            },
                            child: Container(
                              padding: (model.viewing_period == Period.DAILY)
                                  ? EdgeInsets.symmetric(
                                      vertical: sizeMul * 2,
                                      horizontal: sizeMul * 8)
                                  : null,
                              decoration: (model.viewing_period == Period.DAILY)
                                  ? BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(sizeMul * 300))
                                  : null,
                              child: Text(
                                "DAILY",
                                style: (model.viewing_period == Period.DAILY)
                                    ? headerStyleSelected
                                    : headerStyle,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
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
                                      color: Colors.white,
                                      size: MediaQuery.of(context).size.width *
                                          0.08,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 7 * sizeMul,
                      ),
                      ConstrainedBox(
                        constraints: new BoxConstraints(
                          // minHeight: 100*sizeMul,
                          minWidth: 160 * sizeMul,

                          // maxHeight: 30.0,
                          // maxWidth: 30.0,
                        ),
                        child: Material(
                          // shape: CircleBorder(),
                          color: Colors.white.withAlpha(0),
                          child: InkWell(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15 * sizeMul)),
                            onTap: () {
                              print(responseFromNativeCode());
                              // print(result);
                            },
                            splashColor: Colors.greenAccent,
                            highlightColor: Colors.green,
                            child: Container(
                              // height: sizeMul * 80,
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
                                        EdgeInsets.only(bottom: 4 * sizeMul),
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
                                      Radius.circular(15 * sizeMul)),
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
            top: 22 * sizeMul,
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
                        width: 20 * sizeMul,
                      ),
                      Material(
                        color: Colors.white.withOpacity(0),
                        borderRadius: BorderRadius.all(Radius.circular(3000)),
                        child: InkWell(
                          radius: sizeMul * 4,
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
                            size: MediaQuery.of(context).size.width * 0.12,
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
                                Icons.notifications,
                                size: MediaQuery.of(context).size.width * 0.11,
                                color: Colors.white,
                              ),
                              // Positioned()
                              // Container(
                              //   margin: EdgeInsets.all(sizeMul*2),
                              //   child: Image.asset(
                              //     'assets/icons/3x/bell.png',
                              //     height:
                              //         MediaQuery.of(context).size.width * 0.1,
                              //   ),
                              // ),
                              Positioned(
                                top: 14 * sizeMul,
                                right: 5 * sizeMul,
                                child: Container(
                                  width: sizeMul * 18,
                                  height: sizeMul * 18,
                                  child: Center(
                                    child: Text(
                                      "12",
                                      style: TextStyle(
                                          fontSize: 12 * sizeMul,
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
                        width: 20 * sizeMul,
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
                    radius: sizeMul * 20,
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
                        Image.asset(
                          'assets/icons/charts.png',
                          height: MediaQuery.of(context).size.width * 0.098,
                        ),
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
            bottom: MediaQuery.of(context).size.width * 0,
            right: MediaQuery.of(context).size.width * 0.035,
            // right: 12 * sizeMul * sizeMul,
            child: RaisedButton(
                splashColor: greeny.colors[0],
                animationDuration: Duration(milliseconds: 100),
                shape: CircleBorder(),
                elevation: 5,
                color: greeny.colors[1],
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) =>
                              // EditReceiptScreen(model.editReceiptScreenModel)
                              CameraCaptureScreen()
                              ));
                },
                child: Container(
                  width: sizeMul * 74.052,
                  height: sizeMul * 74.052,
                  child: Icon(
                    // print(size);
                    Icons.add,
                    size: sizeMul * 41.14,
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
  goToReceiptsScreen() {
    Navigator.push(
        context, CupertinoPageRoute(builder: (context) => ReceiptScreen()));
  }

  @override
  Widget build(BuildContext context) {
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
      padding: EdgeInsets.symmetric(horizontal: sizeMul * 35),
      child: Center(
        // mainAxisAlignment: MainAxisAlignment.center,
        // children: <Widget>[
        child:
            // SizedBox(width: 30 * MediaQuery.of(context).size.width / 400),
            Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "  Last Receipts",
              style: TextStyle(
                  fontSize: 24 * sizeMul,
                  color: Colors.black.withOpacity(0.8),
                  fontWeight: FontWeight.bold),
            ),
            // SizedBox(
            //   height: sizeMul * 1,
            // ),
            Container(
              height: MediaQuery.of(context).size.height -
                  0.942 * MediaQuery.of(context).size.width -
                  (34 * sizeMul),
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(vertical: sizeMul * 4),
                children: <Widget>[
                  ReceiptCard("May 19, 2019", 99.00, "2 pc Chicken Joy",
                      "assets/icons/3x/jollibee.png", 6),
                  ReceiptCard("May 19, 2019", 66.00, "B'lue water 500 ml",
                      "assets/icons/3x/seven.png", 6),
                  LongButton(
                    greeny.colors[1],
                    333 * sizeMul,
                    69 * sizeMul,
                    sizeMul * 3,
                    Colors.green,
                    greeny.colors[0],
                    sizeMul * 9,
                    goToReceiptsScreen,
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "VIEW ALL",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: sizeMul * 20),
                          ),
                          SizedBox(
                            width: sizeMul * 5,
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                            size: sizeMul * 35,
                          )
                        ],
                      ),
                    ),
                    // null
                  ),
                ],
              ),
            )

            // ReceiptCard("May 19, 2019", 99, "mainItem", "imagePath"),
          ],
        ),
        // SizedBox(width: 30 * MediaQuery.of(context).size.width / 400),
        // ],
      ),
    );
  }
}

String addCommas(int nums) {
  return nums.toString().replaceAllMapped(
      new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
}
