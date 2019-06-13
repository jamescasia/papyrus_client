import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'HomeScreen.dart';
import 'package:papyrus_client/models/ReceiveReceiptModel.dart';
import 'package:papyrus_client/models/AppModel.dart';
import 'package:toast/toast.dart';
import 'dart:io';
import 'package:zoomable_image/zoomable_image.dart';

class ReceiveReceiptScreen extends StatefulWidget {
  ReceiveReceiptModel rrModel;

  ReceiveReceiptScreen(this.rrModel);
  @override
  _ReceiveReceiptScreenState createState() =>
      new _ReceiveReceiptScreenState(rrModel);
}

class _ReceiveReceiptScreenState extends State<ReceiveReceiptScreen> {
  ReceiveReceiptModel rrModel;
  _ReceiveReceiptScreenState(this.rrModel);

  @override
  void initState() {
    // TODO: implement initState

    rrModel.launch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ReceiveReceiptBody(),
    );
  }
}

class ReceiveReceiptBody extends StatefulWidget {
  @override
  _ReceiveReceiptBodyState createState() => new _ReceiveReceiptBodyState();
}

class _ReceiveReceiptBodyState extends State<ReceiveReceiptBody> {
  TextEditingController c = TextEditingController();
  FocusNode f = FocusNode();
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(builder: (context, child, appModel) {
      return ScopedModel<ReceiveReceiptModel>(
          model: appModel.receiveReceiptModel,
          child: ScopedModelDescendant<ReceiveReceiptModel>(
              builder: (context, child, rrModel) {
            rrModel.context = context;
            return new Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                 
                    Container(
                      height: 70,
                      // color: Colors.red,
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        
                        controller: c,
                        focusNode: f,
                        style: TextStyle(color: Colors.black),
                        cursorColor: Colors.red,
                        // backgroundCursorColor: Colors.amber,
                      ),
                    ),
                    RaisedButton(
                      child: Text("sendfile"),
                      onPressed: () {
                        
                        rrModel.sendFile();
                      },
                    ),
                    RaisedButton(
                      child: Text("START CLIENT"),
                      onPressed: () {
                        rrModel.state = "client";
                        rrModel.startClient();
                      },
                    ),
                    RaisedButton(
                      child: Text("START SERVER"),
                      onPressed: () {
                        rrModel.state = "server";
                        rrModel.startServer();
                      },
                    ),
                    RaisedButton(
                      child: Text("SEND"),
                      onPressed: () {
                        rrModel.write(c.text);
                        c.clear();
                      },
                    ),
                    RaisedButton(
                      child: Text("RECEIVE"),
                      onPressed: () {
                        rrModel.connectToWifi();
                      },
                    ),
                    RaisedButton(
                      child: Text("Show toast"),
                      onPressed: () {
                        rrModel.showToast();
                        // Toast.show("Toast plugin app",context,
                        //     duration: Toast.LENGTH_SHORT,
                        //     gravity: Toast.BOTTOM);

                        // rrModel.showToast();
                      },
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: (rrModel.done)?ZoomableImage(FileImage(
                        new File(rrModel.newImage)
                        
                      )):SizedBox(width: 1,),
                    ),

                  ],
                ));
          }));
    });
  }
}
