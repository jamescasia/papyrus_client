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
    rsModel.launch();
    super.initState();
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
                              left: 2,
                              top: 24,
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
                                    height: MediaQuery.of(context).size.width *
                                        0.075,
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
              margin: EdgeInsets.symmetric(horizontal: sizeMul * 20),
              child: (appModel.receiptHeadersAreReady)?   ListView.builder(
                      itemCount: appModel.receiptHeaders.length,
                      itemBuilder: (BuildContext context, int index) {
                        return new ReceiptCard(
                            context,
                            appModel.receiptHeaders[index].date,
                            appModel.receiptHeaders[index].total,
                            appModel.receiptHeaders[index].firstItemName,
                            "assets/icons/3x/seven.png",
                            6);
                      },
                    ):Center(child:CircularProgressIndicator()),
              // child: FutureBuilder(
              //     future: rsModel.fetchReceiptHeaders(),
              //     builder: (context, snapshot) {
              //       if (snapshot.connectionState == ConnectionState.active)
              //         return Center(child: CircularProgressIndicator());
              //       else
              //         return ListView.builder(
              //           itemCount: rsModel.receiptHeaders.length,
              //           itemBuilder: (BuildContext context, int index) {
              //             print(
              //                 "bobod row" + rsModel.receiptHeaders[index].date);
              //             return new ReceiptCard(
              //                 context,
              //                 rsModel.receiptHeaders[index].date,
              //                 rsModel.receiptHeaders[index].total,
              //                 rsModel.receiptHeaders[index].firstItemName,
              //                 "assets/icons/3x/seven.png",
              //                 6);
              //           },
              //         );
              //     }),

              // Center(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: <Widget>[
              //       SizedBox(
              //         height: sizeMul * 170,
              //       ),

              //       ListView.builder(
              //         itemCount: rsModel.receiptHeaders.length,
              //         itemBuilder: (BuildContext context, int index){
              //           return ReceiptCard(rsModel.receiptHeaders[index].date, rsModel.receiptHeaders[index].total, rsModel.receiptHeaders[index].firstItemName, rsModel.receiptHeaders[index].imagePath, 6);
              //           // ReceiptCard(date, total, mainItem, imagePath, margin)

              //         },
              //       ),
              //       // Column(
              //       //   mainAxisSize: MainAxisSize.min,
              //       //   crossAxisAlignment: CrossAxisAlignment.center,
              //       //   children: <Widget>[

              //       //   ],
              //       // ),

              //       SizedBox(
              //         height: 30 * sizeMul,
              //       )
              //     ],
              //   ),
              // )
            );
          }));
    });
  }
}
