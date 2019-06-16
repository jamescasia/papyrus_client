import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'package:papyrus_client/helpers/ClipShadowPath.dart';
import 'package:papyrus_client/helpers/CustomShapeClipper.dart';
import 'package:papyrus_client/helpers/PromoCard.dart';

class PromoScreen extends StatefulWidget {
  @override
  _PromoScreenState createState() => new _PromoScreenState();
}

class _PromoScreenState extends State<PromoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        // color: Colors.white,
        // child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            PromoScreenTopPart()
            // , PromoScreenBottomPart()
          ],
          // ),
        ),
      ),
    );
  }
}

class PromoScreenTopPart extends StatefulWidget {
  @override
  _PromoScreenTopPartState createState() => new _PromoScreenTopPartState();
}

class _PromoScreenTopPartState extends State<PromoScreenTopPart> {
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
              PromoScreenBottomPart(),
            ],
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
                              left: 0,
                              top: 24,
                              child: Container(
                                width: sizeMulW*60,
                                child: RaisedButton(
                                  
                                  highlightElevation: 0,
                                  color: Colors.white.withOpacity(0),
                                  elevation: 0,
                                  splashColor: Colors.white.withAlpha(0),
                                  highlightColor: Colors.black.withOpacity(0), 
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    // width: sizeMulW * 50,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10 * sizeMulW),
                                    // height: sizeMulW*40,
                                    // color: Colors.red,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/icons/3x/back.png',
                                          height:
                                              MediaQuery.of(context).size.width *
                                                  0.075,
                                        ),
                                        
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          Positioned(
                            left: sizeMulW * 30,
                            top: sizeMulW * 70,
                            child: Text("Promos",
                                style: TextStyle(
                                  fontSize: sizeMulW * 35,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                )),
                          )
                        ],
                      ))),
              Positioned(
                  // right: MediaQuery.of(context).size.width * 0.035,
                   left: homeButtonDist,
                  bottom: 0,
                  // top:100,
                  child: RaisedButton(
                      splashColor: greeny.colors[0],
                      animationDuration: Duration(milliseconds: 100),
                      shape: CircleBorder(),
                      elevation: 5,
                      color: greeny.colors[1],
                      onPressed: () {},
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.18,
                        height: MediaQuery.of(context).size.width * 0.18,
                        child:
                            // Image.asset(
                            //   'assets/icons/3x/reset.png',
                            //   height: MediaQuery.of(context).size.width * 0.02,
                            //   width:  MediaQuery.of(context).size.width * 0.02,
                            // ),

                            Icon(
                          Icons.refresh,
                          size: MediaQuery.of(context).size.width * 0.1,
                          color: Colors.white,
                        ),
                      )))
            ],
          ),
        ),
      ]),
    );
  }
}

class PromoScreenBottomPart extends StatefulWidget {
  @override
  _PromoScreenBottomPartState createState() =>
      new _PromoScreenBottomPartState();
}

class _PromoScreenBottomPartState extends State<PromoScreenBottomPart> {
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
                height: sizeMulW * 170,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: sizeMulW * 10),
                width: MediaQuery.of(context).size.width,
                // child: Text(
                //   "May 23, 2019",
                //   textAlign: TextAlign.start,
                //   style: TextStyle(
                //       fontSize: sizeMulW * 17, fontWeight: FontWeight.w500),
                // ),
              ),
              PromoCard("assets/icons/3x/jollibee.png", "300% OFF",
                  "May 19,2019", true, 12, true),
              PromoCard("assets/icons/3x/seven.png", "40% OFF", "May 12,2019",
                  false, 12, false),
              PromoCard("assets/icons/3x/jollibee.png", "300% OFF",
                  "May 11,2019", true, 12, false),
              PromoCard("assets/icons/3x/jollibee.png", "300% OFF",
                  "May 19,2019", true, 12, true),
              PromoCard("assets/icons/3x/seven.png", "40% OFF", "May 12,2019",
                  false, 12, false),
              PromoCard("assets/icons/3x/jollibee.png", "300% OFF",
                  "May 11,2019", true, 12, false),
              PromoCard("assets/icons/3x/jollibee.png", "300% OFF",
                  "May 19,2019", true, 12, true),
              PromoCard("assets/icons/3x/seven.png", "40% OFF", "May 12,2019",
                  false, 12, false),
              PromoCard("assets/icons/3x/jollibee.png", "300% OFF",
                  "May 11,2019", true, 12, false),
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
