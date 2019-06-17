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
      // height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(

          // gradient: greeny,
          color: Colors.green),
      child: Stack(
        children: <Widget>[
          ClipShadowPath(
              shadow: Shadow(
                  blurRadius: 10 * sizeMulW,
                  offset: Offset(0, sizeMulW),
                  color: Colors.black38.withAlpha(0)),
              clipper: CustomShapeClipper(
                  sizeMulW: sizeMulW,
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
                height: sizeMulW * 90,
              ),
              Text(
                "PAPYRUS",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: sizeMulW * 40,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: sizeMulW * 50),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.all(Radius.circular(sizeMulW * 30))),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(sizeMulW * 35)),
                  child: Image.asset(
                    'assets/pictures/sampleqrcode.png',
                    height: MediaQuery.of(context).size.width * 0.7,
                  ),
                ),
              ),
              SizedBox(height: sizeMulW * 10),
              Text(
                "SCAN ME!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: sizeMulW * 60,
                    fontWeight: FontWeight.w900),
              ),
              Text(
                "TO RECEIVE RECEIPT\nWITH ACCOUNT",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: sizeMulW * 18,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Positioned(
            left:2,
            top:   24,
            child: InkWell(
              splashColor: Colors.white.withAlpha(0),
              highlightColor: Colors.black.withOpacity(0.1),
              // ,
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: sizeMulW * 40,
                padding: EdgeInsets.symmetric(vertical: 10 * sizeMulW),
                // height: sizeMulW*40,
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
            bottom: sizeMulW * 40,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: sizeMulW * 40),
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
                              fontSize: 22 * sizeMulW,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: sizeMulW * 12),
                        Icon(Icons.chevron_right,
                            size: sizeMulW * 30, color: Colors.white),
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
          bottom: sizeMulW * 35,
          left: 0,
          // right: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                LongButton(
                  Colors.red, 333 * sizeMulW, 69 * sizeMulW, sizeMulW * 3,
                  Colors.redAccent,
                  Colors.red[800], sizeMulW * 9, null,
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "SIGN OUT",
                          style: TextStyle(
                              color: Colors.white,
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
                      blurRadius: 10 * sizeMulW,
                      offset: Offset(0, sizeMulW),
                      color: Colors.black38),
                  clipper: CustomShapeClipper(
                      sizeMulW: sizeMulW,
                      maxWidth: MediaQuery.of(context).size.width,
                      maxHeight: MediaQuery.of(context).size.width * 0.38),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(gradient: greeny),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: 2,
                            top:   24,
                            child: InkWell(
                              splashColor: Colors.white.withAlpha(0),
                              highlightColor: Colors.black.withOpacity(0.1),
                              // ,
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: sizeMulW * 40,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10 * sizeMulW),
                                // height: sizeMulW*40,
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
                            left: sizeMulW * 30,
                            top: sizeMulW * 70,
                            child: Text("ShowQRs",
                                style: TextStyle(
                                  fontSize: sizeMulW * 35,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                )),
                          )
                        ],
                      ))),
              Positioned(
                  right: sizeMulW * sizeMulW * 12,
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
                          width: sizeMulW * 74.052,
                          height: sizeMulW * 74.052,
                          padding: EdgeInsets.all(sizeMulW * 22),
                          child: Image.asset(
                            'assets/icons/3x/papyrus.png',
                            height: sizeMulW * 5,
                            width: sizeMulW * 5,
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
      // margin: EdgeInsets.symmetric(horizontal: sizeMulW*20),
      child: Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: sizeMulW * 200,
              ),
              Container(
                color: Colors.grey[200],
                height: sizeMulW * 65,
                child: Padding(
                  padding: EdgeInsets.all(18.0 * sizeMulW),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Get notified of unique promos",
                        style: TextStyle(
                            fontSize: sizeMulW * 17,
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
                height: sizeMulW * 65,
                child: Padding(
                  padding: EdgeInsets.all(18.0 * sizeMulW),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Get notified of open-to-all promos",
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: sizeMulW * 17,
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
                height: sizeMulW * 65,
                child: Padding(
                  padding: EdgeInsets.all(18.0 * sizeMulW),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Delete Account",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: sizeMulW * 17,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30 * sizeMulW,
              )
            ],
          ),
        ),
      ),
    );
  }
}
