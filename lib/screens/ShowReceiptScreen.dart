import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'package:papyrus_client/helpers/ClipShadowPath.dart';
import 'package:papyrus_client/helpers/CustomShapeClipper.dart';
import 'package:papyrus_client/data_models/Receipt.dart';

class ShowReceiptScreen extends StatefulWidget {
  Receipt receipt;

  ShowReceiptScreen(this.receipt);
  @override
  _ShowReceiptScreenState createState() => new _ShowReceiptScreenState(this.receipt);
}

class _ShowReceiptScreenState extends State<ShowReceiptScreen> {

  Receipt receipt;
  _ShowReceiptScreenState(this.receipt);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: ShowReceiptScreenStack(receipt));
  }
}

class ShowReceiptScreenStack extends StatefulWidget {

  Receipt receipt;
  ShowReceiptScreenStack(this.receipt);
  @override
  _ShowReceiptScreenStackState createState() =>
      new _ShowReceiptScreenStackState(receipt);
}

class _ShowReceiptScreenStackState extends State<ShowReceiptScreenStack> {
  Receipt receipt;
  _ShowReceiptScreenStackState(this.receipt);
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
                          child: Text(receipt.category , style: TextStyle(fontSize: 40*sizeMul),),
                        ),

                      ],
                    ),
                  ),
                  // The appbar
                 Stack(
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
