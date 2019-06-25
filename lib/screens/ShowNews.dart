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
      floatingActionButton: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.decelerate,
          width: (checked) ? 0 : fabSize,
          height: (checked) ? 0 : fabSize,
          child: RawMaterialButton(
            fillColor: greeny.colors[1],
            shape: new CircleBorder(),
            splashColor: Colors.lightGreen,
            highlightColor: Colors.greenAccent,
            elevation: 5,
            child: new Icon(
              Icons.check,
              color: Colors.white,
              size: 40 * sizeMulW,
            ),
            onPressed: () {
              setState(() {
                checked = true;
              });

              Navigator.pop(context);
            },
          )),
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
        child:  null
      );
    });
  }
}

class ReceiptItemLine extends StatelessWidget {
  // double price;

  // FocusNode f = FocusNode();

  ReceiptItem receiptItem;

  ReceiptItemLine(this.receiptItem);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: sizeMulW * 19, vertical: sizeMulW * 9),
      child: Flex(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              receiptItem.name,
              textScaleFactor: 1,
              style: TextStyle(
                color: Colors.black,
                // fontWeight: FontWeight.w900,
                // fontSize: sizeMulW * 16
              ),
            ),
          ),
          // SizedBox(
          //   width: sizeMulW * 140,
          // ),
          Expanded(
            flex: 1,
            child: Text(
              addCommas(receiptItem.qty).toString(),
              textAlign: TextAlign.center,
              textScaleFactor: 1,
              overflow: TextOverflow.fade,
              style: TextStyle(
                color: Colors.black,
                // fontWeight: FontWeight.w900,
                // fontSize: sizeMulW * 16
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              addCommas(int.parse(
                      receiptItem.price.toStringAsFixed(2).split('.')[0])) +
                  ((receiptItem.price.toStringAsFixed(2).split('.')[1] != null)
                      ? ".${receiptItem.price.toStringAsFixed(2).split('.')[1]}"
                      : ""),
              textAlign: TextAlign.center,
              textScaleFactor: 1,
              style: TextStyle(
                color: Colors.black,
                // fontWeight: FontWeight.w900,
                // fontSize: sizeMulW * 16
              ),
            ),
          ),
          // SizedBox(
          //   width: sizeMulW * 15,
          // ),
          Expanded(
            flex: 2,
            child: Text(
              addCommas(int.parse(
                      receiptItem.total.toStringAsFixed(2).split('.')[0])) +
                  ((receiptItem.total.toStringAsFixed(2).split('.')[1] != null)
                      ? ".${receiptItem.total.toStringAsFixed(2).split('.')[1]}"
                      : ""),
              textScaleFactor: 1,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: Colors.black,
                // fontWeight: FontWeight.w900,
                // fontSize: sizeMulW * 16
              ),
            ),
          )
        ],
      ),
    )

        // return new Container(
        //     margin: EdgeInsets.symmetric(vertical: sizeMulW * 8),
        //     child: Row(
        //       mainAxisSize: MainAxisSize.max,
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       children: <Widget>[
        //         Container(
        //           width: MediaQuery.of(context).size.width * 0.87,
        //           // color: Colors.red,
        //           child: Flex(
        //             direction: Axis.horizontal,
        //             mainAxisSize: MainAxisSize.max,
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: <Widget>[
        //               Expanded(
        //                 flex: 3,
        //                 child: Text(
        //                   receiptItem.name,
        //                   maxLines: 2,
        //                   style: style,
        //                   overflow: TextOverflow.ellipsis,
        //                 ),
        //               ),
        //               Expanded(
        //                 flex: 1,
        //                 child: Text(
        //                   receiptItem.qty.toString(),
        //                   style: style,
        //                   overflow: TextOverflow.ellipsis,
        //                 ),
        //               ),
        //               Expanded(
        //                 flex: 2,
        //                 child: Text(
        //                   receiptItem.price.toStringAsFixed(2),
        //                   style: style,
        //                   overflow: TextOverflow.ellipsis,
        //                 ),
        //               ),
        //               Expanded(
        //                 flex: 3,
        //                 child: Text(
        //                   receiptItem.total.toStringAsFixed(2),
        //                   style: style,
        //                   overflow: TextOverflow.ellipsis,
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),

        //       ],
        //     ));
        ;
  }
}
