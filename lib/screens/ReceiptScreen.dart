import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'package:papyrus_client/helpers/ClipShadowPath.dart';
import 'package:papyrus_client/helpers/CustomShapeClipper.dart';
import 'package:papyrus_client/helpers/ReceiptCard.dart';

class ReceiptScreen extends StatefulWidget {
  @override
  _ReceiptScreenState createState() => new _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        // color: Colors.white,
        // child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ReceiptScreenTopPart()
            // , ReceiptScreenBottomPart()
          ],
          // ),
        ),
      ),
    );
  }
}

class ReceiptScreenTopPart extends StatefulWidget {
  @override
  _ReceiptScreenTopPartState createState() => new _ReceiptScreenTopPartState();
}

class _ReceiptScreenTopPartState extends State<ReceiptScreenTopPart> {
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
              ReceiptScreenBottomPart(),
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
                            left: sizeMul * 1,
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
                            child: Text("Receipts",
                                style: TextStyle(
                                  fontSize: sizeMul * 35,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                )),
                          )
                        ],
                      ))),
              Positioned(
                  // right: sizeMul * sizeMul * 12,

                  right: MediaQuery.of(context).size.width * 0.035,
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
                      child: Icon(
                        Icons.add,
                        size: MediaQuery.of(context).size.width * 0.1,
                        color: Colors.white,
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ]),
    );
  }
}

class ReceiptScreenBottomPart extends StatefulWidget {
  @override
  _ReceiptScreenBottomPartState createState() =>
      new _ReceiptScreenBottomPartState();
}

class _ReceiptScreenBottomPartState extends State<ReceiptScreenBottomPart> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: MediaQuery.of(context).size.width,
      // margin: EdgeInsets.symmetric(horizontal: sizeMul*20),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: sizeMul * 170,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: sizeMul * 10),
              child: Text(
                "May 23, 2019",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: sizeMul * 17, fontWeight: FontWeight.w500),
              ),
            ),
            ReceiptCard("May 19, 2019", 99.00, "2 pc Chicken Joy",
                "assets/icons/3x/jollibee.png", 8),
            ReceiptCard("May 19, 2019", 66.00, "B'lue water 500 ml",
                "assets/icons/3x/seven.png", 8),
            ReceiptCard("May 19, 2019", 99.00, "2 pc Chicken Joy",
                "assets/icons/3x/jollibee.png", 8),
            Container(
              margin: EdgeInsets.symmetric(vertical: sizeMul * 10),
              child: Text(
                "May 22, 2019",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: sizeMul * 17, fontWeight: FontWeight.w500),
              ),
            ),
            ReceiptCard("May 19, 2019", 66.00, "B'lue water 500 ml",
                "assets/icons/3x/seven.png", 8),
            ReceiptCard("May 19, 2019", 99.00, "2 pc Chicken Joy",
                "assets/icons/3x/jollibee.png", 8),
            ReceiptCard("May 19, 2019", 66.00, "B'lue water 500 ml",
                "assets/icons/3x/seven.png", 8),
            ReceiptCard("May 19, 2019", 66.00, "B'lue water 500 ml",
                "assets/icons/3x/jollibee.png", 8),
            ReceiptCard("May 19, 2019", 99.00, "2 pc Chicken Joy",
                "assets/icons/3x/seven.png", 8),
            Container(
              margin: EdgeInsets.symmetric(vertical: sizeMul * 10),
              child: Text(
                "May 21, 2019",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: sizeMul * 17, fontWeight: FontWeight.w500),
              ),
            ),
            ReceiptCard("May 19, 2019", 66.00, "B'lue water 500 ml",
                "assets/icons/3x/jollibee.png", 8),
            SizedBox(
              height: 30 * sizeMul,
            )
          ],
        ),
      ),
    );
  }
}
