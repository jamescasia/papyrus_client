import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'package:papyrus_client/helpers/ClipShadowPath.dart';
import 'package:papyrus_client/helpers/CustomShapeClipper.dart';

class ShowReceiptScreen extends StatefulWidget {
  @override
  _ShowReceiptScreenState createState() => new _ShowReceiptScreenState();
}

class _ShowReceiptScreenState extends State<ShowReceiptScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: ShowReceiptScreenStack());
  }
}

class ShowReceiptScreenStack extends StatefulWidget {
  @override
  _ShowReceiptScreenStackState createState() =>
      new _ShowReceiptScreenStackState();
}

class _ShowReceiptScreenStackState extends State<ShowReceiptScreenStack> {
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
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 50 * sizeMul,
                        ),
                      ],
                    ),
                  ),
                  // The appbar
                  new Stack(
                    children: <Widget>[
                      ClipShadowPath(
                          shadow: Shadow(
                              blurRadius: 10 * sizeMul,
                              offset: Offset(0, sizeMul),
                              color: Colors.black38),
                          clipper: CustomShapeClipper(
                              sizeMul: sizeMul,
                              maxWidth: MediaQuery.of(context).size.width,
                              maxHeight:
                                  MediaQuery.of(context).size.width * 0.38),
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(gradient: greeny),
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    left:2,
                                    top:   24,
                                    child: InkWell(
                                      splashColor: Colors.white.withAlpha(0),
                                      highlightColor:
                                          Colors.black.withOpacity(0.1),
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
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.075,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: sizeMul * 30,
                                    top: sizeMul * 70,
                                    child: Text("Receipt",
                                        style: TextStyle(
                                          fontSize: sizeMul * 35,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  )
                                ],
                              ))),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
