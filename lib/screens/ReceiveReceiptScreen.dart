import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'HomeScreen.dart';
import 'package:papyrus_client/models/ReceiveReceiptModel.dart';
import 'package:papyrus_client/models/AppModel.dart';

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
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(builder: (context, child, appModel) {
      return ScopedModel<ReceiveReceiptModel>(
          model: appModel.receiveReceiptModel,
          child: ScopedModelDescendant<ReceiveReceiptModel>(
              builder: (context, child, rrModel) {
            return new Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Receiving receipt", style: TextStyle(fontSize: sizeMul*40),),
                    RaisedButton(
                      onPressed: () {
                        rrModel.connectToWifi();
                      },
                    ),
                  ],
                ));
          }));
    });
  }
}
