import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'package:papyrus_client/helpers/ClipShadowPath.dart';
import 'package:papyrus_client/helpers/CustomShapeClipper.dart';
import 'package:papyrus_client/data_models/Receipt.dart';
import 'package:flutter/cupertino.dart';
import 'ReceiptScreen.dart';
import 'package:papyrus_client/models/AppModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:flutter_web_view/flutter_web_view.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:papyrus_client/data_models/News.dart';

class ShowNewsScreen extends StatefulWidget {
  News news;

  ShowNewsScreen(this.news);
  @override
  _ShowNewsScreenState createState() =>
      new _ShowNewsScreenState(news);
}

class _ShowNewsScreenState extends State<ShowNewsScreen> {
  News news;

  double fabSize = (0.5 * (sizeMulW + sizeMulH)) * 74.052;
  bool checked = false;
  _ShowNewsScreenState(this.news);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // floatingActionButton: AnimatedContainer(
      //     duration: Duration(milliseconds: 200),
      //     curve: Curves.decelerate,
      //     width: (checked) ? 0 : fabSize,
      //     height: (checked) ? 0 : fabSize,
      //     child: RawMaterialButton(
      //       fillColor: greeny.colors[1],
      //       shape: new CircleBorder(),
      //       splashColor: Colors.lightGreen,
      //       highlightColor: Colors.greenAccent,
      //       elevation: 5,
      //       child: new Icon(
      //         Icons.check,
      //         color: Colors.white,
      //         size: 40 * sizeMulW,
      //       ),
      //       onPressed: () {
      //         setState(() {
      //           checked = true;
      //         });

      //         Navigator.pop(context);
      //       },
      //     )),
      body: ShowNewsScreenStack(news),
    );
  }
}

class ShowNewsScreenStack extends StatefulWidget {
  News news;
  ShowNewsScreenStack(this.news);
  @override
  _ShowNewsScreenStackState createState() =>
      new _ShowNewsScreenStackState(news);
}

class _ShowNewsScreenStackState extends State<ShowNewsScreenStack> {
  News news;
  _ShowNewsScreenStackState(this.news);

  @override
  Widget build(BuildContext context) { 
    return ScopedModelDescendant<AppModel>(
        // stream: null,
        builder: (context, child, appModel) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child:  WebView(
          initialUrl: news.url,
        )
      );
    });
  }
}
 