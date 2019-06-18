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

class ShowReceiptScreen extends StatefulWidget {
  Receipt receipt;

  ShowReceiptScreen(this.receipt);
  @override
  _ShowReceiptScreenState createState() =>
      new _ShowReceiptScreenState(this.receipt);
}

class _ShowReceiptScreenState extends State<ShowReceiptScreen> {
  Receipt receipt;
  _ShowReceiptScreenState(this.receipt);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          
        },
      ),
      body: ShowReceiptScreenStack(receipt), 
    );
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
        Color iconColor; 

  if (receipt.category == "Transportation") iconColor = Color(0xff8ec8f8); 
  if (receipt.category == "Miscellaneous") iconColor = Color(0xffee9698); 
  if (receipt.category == "Utilities") iconColor = Color(0xffa1d2a6); 
  if (receipt.category == "Leisure") iconColor = Color(0xfffef09c); 
  if (receipt.category == "Food") iconColor = Color(0xfff4a735);

    TextStyle headerStyleSelected = TextStyle(
        fontSize: MediaQuery.of(context).size.width * 0.05,
        fontWeight: FontWeight.bold,
        color: Colors.green[700]);
    return ScopedModelDescendant<AppModel>(
        // stream: null,
        builder: (context, child, appModel) {
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
                            height: 160 * sizeMulW,
                          ),
                          Container(
                            width: 300 * sizeMulW,
                            child: Text(
                              receipt.merchant,
                              // "Jollibee Foods Corporation",
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 26 * sizeMulH,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          // Text(
                          //   receipt.address,
                          //   textAlign: TextAlign.center,
                          // ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(
                                height: sizeMulW * 35,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(right: sizeMulW * 19),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      DateFormat('MM/dd/yyyy hh:mm')
                                          .format(
                                              DateTime.parse(receipt.dateTime))
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          // fontWeight: FontWeight.w600,
                                          fontSize: sizeMulW * 17),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: sizeMulW * 23,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: sizeMulW * 60),
                                child: Text(
                                  "ITEMS",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: sizeMulW * 20),
                                ),
                              ),
                              SizedBox(
                                height: sizeMulW * 23,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: sizeMulW * 25,
                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Flex(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    direction: Axis.horizontal,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          "NAME",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: sizeMulW * 18),
                                        ),
                                      ),
                                      // SizedBox(
                                      //   width: sizeMulW * 140,
                                      // ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "QTY",
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: sizeMulW * 18),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          " PRICE",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: sizeMulW * 18),
                                        ),
                                      ),
                                      // SizedBox(
                                      //   width: sizeMulW * 15,
                                      // ),
                                      Expanded(
                                        flex: 2,
                                        child: Text("TOTAL",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: sizeMulW * 18,
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: sizeMulW * 10,
                                    vertical: sizeMulH * 10),
                                child: Column(
                                  children: receipt.items.map((f) {
                                    return ReceiptItemLine(f);
                                  }).toList(),

                                  // <Widget>[
                                  //   Column(
                                  //       children: receipt.items.map((item) {
                                  //     return Text(item.name);
                                  //   }).toList()),
                                  // ]
                                ),
                              ),
                              SizedBox(
                                height: 13 * sizeMulW,
                              ),
                              Container(
                                padding: EdgeInsets.only(top: sizeMulW * 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Text(
                                      "TOTAL",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17 * sizeMulW,
                                        // fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(
                                      // "${((erModel.receipt.total.toStringAsFixed(2)))}",

                                      addCommas(int.parse(receipt.total
                                              .toStringAsFixed(2)
                                              .split('.')[0])) +
                                          ((receipt.total
                                                      .toStringAsFixed(2)
                                                      .split('.')[1] !=
                                                  null)
                                              ? ".${receipt.total.toStringAsFixed(2).split('.')[1]}"
                                              : ""),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17 * sizeMulW,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(top: sizeMulW * 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "CONTINUE",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17 * sizeMulW,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: sizeMulW * 30,
                          ),

                          Text(
                            "Made with ❤ \nby AetherApps",
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: sizeMulW * 50,
                          ),
                        ],
                      ),
                    ),
                    // The appbar
                    Stack(
                      children: <Widget>[
                        ClipShadowPath(
                            shadow: Shadow(
                                blurRadius: 10 * sizeMulW,
                                offset: Offset(0, sizeMulW),
                                color: Colors.black38),
                            clipper: CustomShapeClipper(
                                sizeMulW: sizeMulW,
                                maxWidth: MediaQuery.of(context).size.width,
                                maxHeight:
                                    MediaQuery.of(context).size.width * 0.38),
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.width * 0.38,
                                decoration: BoxDecoration(gradient: greeny),
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                      left: 0,
                                      top: 24,
                                      child: Container(
                                        width: sizeMulW * 60,
                                        child: RaisedButton(
                                          highlightElevation: 0,
                                          color: Colors.white.withOpacity(0),
                                          elevation: 0,
                                          splashColor:
                                              Colors.white.withAlpha(0),
                                          highlightColor:
                                              Colors.black.withOpacity(0),
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Image.asset(
                                                  'assets/icons/3x/back.png',
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
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
                                      child: Text("Receipt",
                                          style: TextStyle(
                                            fontSize: sizeMulW * 35,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                  ],
                                ))),
                        Positioned(
                          left: homeButtonDist + sizeMulW * 32,
                          bottom: 13,
                          child: Icon(
                            (receipt.category == "Leisure")
                                ? FontAwesomeIcons.wineGlassAlt
                                : (receipt.category == "Transportation")
                                    ? FontAwesomeIcons.bus
                                    : (receipt.category == "Food")
                                        ? FontAwesomeIcons.utensils
                                        : (receipt.category == "Utilities")
                                            ? FontAwesomeIcons.toiletPaper
                                            : (receipt.category ==
                                                    "Miscellaneous")
                                                ? FontAwesomeIcons.campground
                                                : FontAwesomeIcons.file,
                            size: sizeMulW * 35,
                            color: iconColor,
                          ),
                          // Icon(
                          //   // Icons.image,
                          //   FontAwesomeIcons.file,
                          //   size: sizeMulW * 35,
                          //   color: Colors.green,
                          // )
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
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
    TextStyle style = TextStyle(
        fontSize: sizeMulW * 19,
        color: Colors.black,
        fontWeight: FontWeight.w300);

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
              style: TextStyle(
                  color: Colors.black,
                  // fontWeight: FontWeight.w900,
                  fontSize: sizeMulW * 16),
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
              overflow: TextOverflow.fade,
              style: TextStyle(
                  color: Colors.black,
                  // fontWeight: FontWeight.w900,
                  fontSize: sizeMulW * 16),
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
              style: TextStyle(
                  color: Colors.black,
                  // fontWeight: FontWeight.w900,
                  fontSize: sizeMulW * 16),
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
              textAlign: TextAlign.end,
              style: TextStyle(
                  color: Colors.black,
                  // fontWeight: FontWeight.w900,
                  fontSize: sizeMulW * 16),
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
