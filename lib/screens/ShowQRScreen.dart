import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'package:papyrus_client/helpers/ClipShadowPath.dart';
import 'package:papyrus_client/helpers/CustomShapeClipper.dart';
import 'package:papyrus_client/helpers/LongButton.dart';

class ShowQRScreen extends StatefulWidget {
  @override
  _ShowQRScreenState createState() => new _ShowQRScreenState();
}

class _ShowQRScreenState extends State<ShowQRScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShowQRScreenStack(),
    );
  }
}

class ShowQRScreenStack extends StatefulWidget {
  @override
  _ShowQRScreenStackState createState() => new _ShowQRScreenStackState();
}

class _ShowQRScreenStackState extends State<ShowQRScreenStack> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(

          // gradient: greeny,
          color: Colors.green),
      child: Stack(
        children: <Widget>[
          ClipShadowPath(
              shadow: Shadow(
                  blurRadius: 10 * sizeMul,
                  offset: Offset(0, sizeMul),
                  color: Colors.black38.withAlpha(0)),
              clipper: CustomShapeClipper(
                  sizeMul: sizeMul,
                  maxWidth: MediaQuery.of(context).size.width,
                  maxHeight: MediaQuery.of(context).size.width * 0.91),
              child: Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: double.infinity,
              )),
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: sizeMul * 90,
              ),
              Text(
                "PAPYRUS",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: sizeMul * 40,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: sizeMul * 50),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.all(Radius.circular(sizeMul * 30))),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(sizeMul * 35)),
                  child: Image.asset(
                    'assets/pictures/sampleqrcode.png',
                    height: MediaQuery.of(context).size.width * 0.7,
                  ),
                ),
              ),
              SizedBox(height: sizeMul * 10),
              Text(
                "SCAN ME!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: sizeMul * 60,
                    fontWeight: FontWeight.w900),
              ),
              Text(
                "TO RECEIVE RECEIPT\nWITH ACCOUNT",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: sizeMul * 18,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Positioned(
            left: sizeMul * 9,
            top: sizeMul * 24,
            child: InkWell(
              splashColor: Colors.white.withAlpha(0),
              highlightColor: Colors.black.withOpacity(0.1),
              // ,
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: sizeMul * 40,
                padding: EdgeInsets.symmetric(vertical: 10 * sizeMul),
                // height: sizeMul*40,
                // color: Colors.red,
                child: Image.asset(
                  'assets/icons/3x/back.png',
                  color: Colors.black,
                  height: MediaQuery.of(context).size.width * 0.075,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: sizeMul * 40,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: sizeMul * 40),
              child: Material(
                color: Colors.white.withAlpha(0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  splashColor: Colors.red,
                  highlightColor: Colors.green,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "CONTINUE",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22 * sizeMul,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: sizeMul * 12),
                        Icon(Icons.chevron_right,
                            size: sizeMul * 30, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ShowQRScreenTopPart extends StatefulWidget {
  @override
  _ShowQRScreenTopPartState createState() => new _ShowQRScreenTopPartState();
}

class _ShowQRScreenTopPartState extends State<ShowQRScreenTopPart> {
  @override
  Widget build(BuildContext context) {
    TextStyle headerStyle = TextStyle(
        fontSize: MediaQuery.of(context).size.width * 0.045,
        fontWeight: FontWeight.normal,
        color: Colors.white);

    TextStyle headerStyleSelected = TextStyle(
        fontSize: MediaQuery.of(context).size.width * 0.05,
        fontWeight: FontWeight.bold,
        color: Colors.green[700]);
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(children: <Widget>[
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ShowQRScreenBottomPart(),
            ],
          ),
        ),
        Positioned(
          bottom: sizeMul * 35,
          left: 0,
          // right: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                LongButton(
                  Colors.red, 333 * sizeMul, 69 * sizeMul, sizeMul * 3,
                  Colors.redAccent,
                  Colors.red[800], sizeMul * 9, null,
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "SIGN OUT",
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
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.width * 0.414,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              ClipShadowPath(
                  shadow: Shadow(
                      blurRadius: 10 * sizeMul,
                      offset: Offset(0, sizeMul),
                      color: Colors.black38),
                  clipper: CustomShapeClipper(
                      sizeMul: sizeMul,
                      maxWidth: MediaQuery.of(context).size.width,
                      maxHeight: MediaQuery.of(context).size.width * 0.38),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(gradient: greeny),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: sizeMul * 9,
                            top: sizeMul * 24,
                            child: InkWell(
                              splashColor: Colors.white.withAlpha(0),
                              highlightColor: Colors.black.withOpacity(0.1),
                              // ,
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: sizeMul * 40,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10 * sizeMul),
                                // height: sizeMul*40,
                                // color: Colors.red,
                                child: Image.asset(
                                  'assets/icons/3x/back.png',
                                  height:
                                      MediaQuery.of(context).size.width * 0.075,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: sizeMul * 30,
                            top: sizeMul * 70,
                            child: Text("ShowQRs",
                                style: TextStyle(
                                  fontSize: sizeMul * 35,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                )),
                          )
                        ],
                      ))),
              Positioned(
                  right: sizeMul * sizeMul * 12,
                  bottom: 0,
                  // top:100,
                  child: Tooltip(
                    message: "View Papyrus stores nationwide",
                    child: RaisedButton(
                        splashColor: greeny.colors[0],
                        animationDuration: Duration(milliseconds: 100),
                        shape: CircleBorder(),
                        elevation: 5,
                        color: greeny.colors[1],
                        onPressed: () {},
                        child: Container(
                          width: sizeMul * 74.052,
                          height: sizeMul * 74.052,
                          padding: EdgeInsets.all(sizeMul * 22),
                          child: Image.asset(
                            'assets/icons/3x/papyrus.png',
                            height: sizeMul * 5,
                            width: sizeMul * 5,
                          ),

                          //     Icon(
                          //   Icons.refresh,
                          //   size: MediaQuery.of(context).size.width * 0.1,
                          //   color: Colors.white,
                          // ),
                        )),
                  ))
            ],
          ),
        ),
      ]),
    );
  }
}

class ShowQRScreenBottomPart extends StatefulWidget {
  @override
  _ShowQRScreenBottomPartState createState() =>
      new _ShowQRScreenBottomPartState();
}

class _ShowQRScreenBottomPartState extends State<ShowQRScreenBottomPart> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: MediaQuery.of(context).size.width,
      // margin: EdgeInsets.symmetric(horizontal: sizeMul*20),
      child: Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: sizeMul * 200,
              ),
              Container(
                color: Colors.grey[200],
                height: sizeMul * 65,
                child: Padding(
                  padding: EdgeInsets.all(18.0 * sizeMul),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Get notified of unique promos",
                        style: TextStyle(
                            fontSize: sizeMul * 17,
                            fontWeight: FontWeight.w600),
                      ),
                      Switch(
                        value: false,
                        onChanged: null,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                // color: Colors.grey[200],
                height: sizeMul * 65,
                child: Padding(
                  padding: EdgeInsets.all(18.0 * sizeMul),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Get notified of open-to-all promos",
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: sizeMul * 17,
                            fontWeight: FontWeight.w600),
                      ),
                      Switch(
                        value: false,
                        onChanged: null,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.grey[200],
                height: sizeMul * 65,
                child: Padding(
                  padding: EdgeInsets.all(18.0 * sizeMul),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Delete Account",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: sizeMul * 17,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30 * sizeMul,
              )
            ],
          ),
        ),
      ),
    );
  }
}
