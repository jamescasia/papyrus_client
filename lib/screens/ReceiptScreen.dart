import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'package:papyrus_client/helpers/ClipShadowPath.dart';
import 'package:papyrus_client/helpers/CustomShapeClipper.dart';
import 'package:papyrus_client/helpers/ReceiptCard.dart';
import 'GetReceiptScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:papyrus_client/models/AppModel.dart';
import 'package:papyrus_client/models/ReceiptsScreenModel.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:papyrus_client/data_models/Receipt.dart';

class ReceiptScreen extends StatefulWidget {
  ReceiptsScreenModel rsModel;

  ReceiptScreen(this.rsModel);
  @override
  _ReceiptScreenState createState() => new _ReceiptScreenState(rsModel);
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  ReceiptsScreenModel rsModel;

  _ReceiptScreenState(this.rsModel);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rsModel.launch();
  }

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
    return ScopedModelDescendant<AppModel>(builder: (context, child, appModel) {
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(children: <Widget>[
          ReceiptScreenBottomPart(),
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
                              top: MediaQuery.of(context).size.width * 0.38*0.45,
                              child: Text("Receipts",
                                  style: TextStyle(
                                    fontSize: sizeMulW * 35,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )),
                            )
                          ],
                        ))),
                Positioned(
                    // right: sizeMulW * sizeMulW * 12,

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
                      onPressed: () {
                        Navigator.push(context,
                            CupertinoPageRoute(builder: (context) {
                          return
                              // EditReceiptScreen(appModel.editReceiptScreenModel)
                              // CameraCaptureScreen()
                              GetReceiptScreen(appModel.cameraCaptureModel);
                        }));
                      },
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
    });
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
    return ScopedModelDescendant<AppModel>(builder: (context, child, appModel) {
      return ScopedModel<ReceiptsScreenModel>(
          model: appModel.receiptsScreenModel,
          child: ScopedModelDescendant<ReceiptsScreenModel>(
              builder: (context, child, rsModel) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.symmetric(horizontal: sizeMulW * 37),
              child: (true)
                  ? ListView.builder(
                      // reverse: true,
                      itemCount: appModel.receiptFiles.length,
                      itemBuilder: (BuildContext context, int index) {
                        // var receipt = appModel.receipts[index];
                        // DateFormat("MMM dd, yyyy")
                        //         .format(DateTime.parse(receipt.dateTime))

                        File rJSON = File(appModel.receiptFiles[index].path);
                        Map map = jsonDecode(rJSON.readAsStringSync());
                        var receipt = Receipt.fromJson(map);

                        var dateCurr = DateFormat("MMM dd, yyyy")
                            .format(DateTime.parse(receipt.dateTime));
                        var datePrev = dateCurr;

                        if (index >= 1) {
                          File rJSON1 =
                              File(appModel.receiptFiles[index - 1].path);
                          Map map1 = jsonDecode(rJSON1.readAsStringSync());
                          var receipt1 = Receipt.fromJson(map1);
                          datePrev = DateFormat("MMM dd, yyyy")
                              .format(DateTime.parse(receipt1.dateTime));
                        }

                        return Container(
                          margin: (index == 0)
                              ? EdgeInsets.only(
                                  bottom: sizeMulW * 9, top: sizeMulW * 130)
                              : (index == appModel.receiptFiles.length - 1)
                                  ? EdgeInsets.only(
                                      top: sizeMulW * 9, bottom: sizeMulW * 50)
                                  : EdgeInsets.symmetric(vertical: sizeMulW * 9),
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                (dateCurr != datePrev || index == 0)
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            bottom: sizeMulW * 18),
                                        child: Text(
                                          "    " + dateCurr.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ))
                                    : SizedBox(width: 1),
                                ReceiptCard(context, receipt, index),
                              ]),
                        );
                        // return Text("hello${appModel.receipts[index].items[0].name}",style: TextStyle(fontSize: 50,));
                      },
                    )
                  : Center(child: CircularProgressIndicator()),
            );
          }));
    });
  }
}
