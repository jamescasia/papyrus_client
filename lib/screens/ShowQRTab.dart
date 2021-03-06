import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'package:papyrus_client/helpers/ClipShadowPath.dart';
import 'package:papyrus_client/helpers/CustomShapeClipper.dart';
import 'package:papyrus_client/helpers/LongButton.dart';
import 'package:ef_qrcode/ef_qrcode.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:papyrus_client/models/AppModel.dart';
import 'dart:io';

class ShowQRTab extends StatefulWidget {
  @override
  _ShowQRTabState createState() => new _ShowQRTabState();
}

class _ShowQRTabState extends State<ShowQRTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShowQRTabStack(),
    );
  }
}

class ShowQRTabStack extends StatefulWidget {
  @override
  _ShowQRTabStackState createState() => new _ShowQRTabStackState();
}

class _ShowQRTabStackState extends State<ShowQRTabStack> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
        // stream: null,
        builder: (context, child, appModel) {
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
                  // height: double.infinity,
                )),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: sizeMulW * 125,
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
                    borderRadius:
                        BorderRadius.all(Radius.circular(sizeMulW * 55)),
                    child: Center(
                      child: (appModel.imageQrLoaded)
                          ? Image.file(
                              appModel.qrCodeFile,
                              scale: 1.05,
                            )
                          : Text(
                              "File does not exist",
                              style: TextStyle(fontSize: sizeMulW * 23),
                            ),
                    ),

                    // Image.asset(
                    //   'assets/pictures/sampleqrcode.png',
                    //   height: MediaQuery.of(context).size.width * 0.7,
                    // ),
                  ),
                ),
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
                      fontSize: sizeMulW * 19,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
