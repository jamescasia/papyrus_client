import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'package:papyrus_client/helpers/ClipShadowPath.dart';
import 'package:papyrus_client/helpers/CustomShapeClipper.dart';
import 'package:papyrus_client/helpers/ReceiptCard.dart';
import 'package:zoomable_image/zoomable_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:papyrus_client/models/EditReceiptScreenModel.dart';
import 'package:papyrus_client/data_models/Receipt.dart';
import 'dart:core';
import 'package:papyrus_client/models/AppModel.dart';
import 'dart:io';
import 'CameraCaptureScreen.dart';
import 'package:flutter/cupertino.dart';
import 'ShowReceiptScreen.dart';
// import ''
// import 'dart:core';

class EditReceiptScreen extends StatelessWidget {
  final EditReceiptScreenModel editReceiptScreenModel;
  EditReceiptScreen(this.editReceiptScreenModel);
  @override
  @override
  Widget build(BuildContext context) {
    editReceiptScreenModel.launch();
    return Scaffold(body: Container(
        // color: Colors.white,
        // child: SingleChildScrollView(
        child: ScopedModelDescendant<AppModel>(
            builder: (context, child, appModel) {
      // editReceiptScreenModel = appModel.editReceiptScreenModel;
      return ScopedModel<EditReceiptScreenModel>(
          model: appModel.editReceiptScreenModel,
          // stream: null,
          child: EditReceiptScreenScrollPart());
    }
            // })

            // Column(
            //   children: <Widget>[
            //     EditReceiptScreenTopPart()
            //     // , EditReceiptScreenBottomPart()
            //   ],
            //   // ),
            // ),

            )));
  }
}

class EditReceiptScreenScrollPart extends StatefulWidget {
//   final AppModel appModel;
// final EditReceiptScreenModel editReceiptScreenModel;

  // EditReceiptScreenScrollPart(this.appModel, this.editReceiptScreenModel);
  @override
  _EditReceiptScreenScrollPartState createState() =>
      new _EditReceiptScreenScrollPartState();
}

BuildContext ctx;

class _EditReceiptScreenScrollPartState
    extends State<EditReceiptScreenScrollPart> {
// final EditReceiptScreenModel editReceiptScreenModel;
//   AppModel appModel;
//   _EditReceiptScreenScrollPartState(this.appModel, this.editReceiptScreenModel);

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor:
                  //  Colors.red,
                  greeny.colors[0],
              expandedHeight: 340.0 * sizeMul,
              floating: false,
              automaticallyImplyLeading: false,
              pinned: false,
              // title: Container(
              //   color: Colors.red,
              //   width: MediaQuery.of(context).size.width,
              //   height: 100,
              // ),
              flexibleSpace: EditReceiptScreenTopPart(),
            ),
            // SliverChildListDelegate(children)
          ];
        },
        body: ScopedModelDescendant<EditReceiptScreenModel>(
            // stream: null,
            builder: (context, child, editReceiptScreenModel) {
          return EditReceiptScreenBottomPart(editReceiptScreenModel);
        }),
      ),
    );
  }
}

class EditReceiptScreenTopPart extends StatelessWidget {
  static const platform = const MethodChannel('flutter.native/helper');

  void initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
  }

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
        background: ScopedModelDescendant<EditReceiptScreenModel>(
            // stream: null,
            builder: (context, child, editReceiptScreenModel) {
      return Stack(
        children: <Widget>[
          ClipShadowPath(
              shadow: Shadow(
                  blurRadius: 10 * sizeMul,
                  offset: Offset(0, sizeMul),
                  color: Colors.black38.withAlpha(0)),
              clipper: CustomShapeClipper(
                  sizeMul: sizeMul,
                  maxWidth: MediaQuery.of(context).size.width,
                  maxHeight: MediaQuery.of(context).size.width * 0.91),
              child: ZoomableImage(
                FileImage(File(editReceiptScreenModel.receipt.imagePath)),
                // AssetImage("assets/pictures/receipt-sample.jpg"),
                // yawa

                backgroundColor: Colors.grey[700],
              )),
          Positioned(
            left: 2,
            top: 24,
            child: InkWell(
              splashColor: Colors.white.withAlpha(0),
              highlightColor: Colors.black.withOpacity(0.1),
              // ,
              onTap: () {
                // editReceiptScreenModel = EditReceiptScreenModel();

                Navigator.pop(context);
                editReceiptScreenModel.deleteReceiptImage();
              },
              child: Container(
                width: sizeMul * 40,
                padding: EdgeInsets.symmetric(vertical: 10 * sizeMul),
                // height: sizeMul*40,
                // color: Colors.red,
                child: Image.asset(
                  'assets/icons/3x/back.png',
                  height: MediaQuery.of(context).size.width * 0.075,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: sizeMul * 15,
            // right: 48 * sizeMul * sizeMul,
            left: homeButtonDist + 40 * sizeMul,
            child: Material(
              color: Colors.white.withOpacity(0),
              borderRadius: BorderRadius.all(Radius.circular(3000)),
              child: InkWell(
                radius: sizeMul * 24,
                splashColor: Colors.white.withAlpha(0),
                highlightColor: Colors.black.withOpacity(0.1),
                borderRadius: BorderRadius.all(Radius.circular(3000)),
                onTap: () {
                  editReceiptScreenModel.deleteReceiptImage();

                  Navigator.of(context).pop();

                  // editReceiptScreenModel = EditReceiptScreenModel();
                  // editReceiptScreenModel.changed=!editReceiptScreenModel.changed;
                  // editReceiptScreenModel.update();
                },
                child: Icon(
                  Icons.camera_alt,
                  size: sizeMul * 40,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      );
    }));
  }
}

class EditReceiptScreenBottomPart extends StatefulWidget {
  EditReceiptScreenModel editReceiptScreenModel;

  EditReceiptScreenBottomPart(this.editReceiptScreenModel);
  @override
  _EditReceiptScreenBottomPartState createState() =>
      new _EditReceiptScreenBottomPartState(editReceiptScreenModel);
}

class _EditReceiptScreenBottomPartState
    extends State<EditReceiptScreenBottomPart> {
  EditReceiptScreenModel editReceiptScreenModel;
  _EditReceiptScreenBottomPartState(this.editReceiptScreenModel);
  TextEditingController merchant_controller = TextEditingController();
  TextEditingController date_controller = TextEditingController();
  FocusNode m_focus = FocusNode();
  FocusNode d_focus = FocusNode();
  String catChoice = "Food";
  @override
  void initState() {
    merchant_controller.text = editReceiptScreenModel.receipt.merchant;
    date_controller.text = editReceiptScreenModel.receipt.dateTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ScopedModelDescendant
    // FocusNode
    return ScopedModelDescendant<EditReceiptScreenModel>(
        rebuildOnChange: true,
        builder: (context, child, erModel) {
          ctx = context;

          return ScopedModelDescendant<AppModel>(
              // stream: null,
              builder: (context, child, appModel) {
            erModel.receipt.category = catChoice;
            return new Container(
              width: MediaQuery.of(context).size.width,
              // padding: EdgeInsets.only(top:sizeMul*10),
              // height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: greeny,
              ),
              // height: MediaQuery.of(context).size.height,
              // margin: EdgeInsets.symmetric(horizontal: sizeMul*20),
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: sizeMul * 15, vertical: sizeMul * 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            flex: 60,
                            child: Container(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: sizeMul * 8.0),
                                  child: Text(
                                    "MERCHANT",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: sizeMul * 14),
                                  ),
                                ),
                                SizedBox(height: sizeMul * 4),
                                Container(
                                  // width: sizeMul * 200,
                                  height: sizeMul * 40,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: sizeMul * 15),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(3000)),
                                      border: Border.all(
                                          color: Colors.white,
                                          width: sizeMul * 2)),
                                  child: Center(
                                    child: EditableText(
                                      autofocus: false,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: sizeMul * 20),
                                      backgroundCursorColor: Colors.red,
                                      cursorColor: Colors.pinkAccent,
                                      focusNode: m_focus,
                                      controller: merchant_controller,
                                      onChanged: (merchant) {
                                        erModel.receipt.merchant = merchant;

                                        erModel.update();
                                      },
                                    ),
                                  ),
                                )
                              ],
                            )),
                          ),
                          Expanded(
                            flex: 3,
                            child: SizedBox(
                              width: 1,
                            ),
                          ),
                          // SizedBox(
                          //   width: sizeMul * 20,
                          // ),
                          Expanded(
                            flex: 35,
                            child: Container(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: sizeMul * 8.0),
                                  child: Text(
                                    "DATE & TIME",
                                    // maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: sizeMul * 14),
                                  ),
                                ),
                                SizedBox(height: sizeMul * 4),
                                Container(
                                  // width: sizeMul * 130,
                                  height: sizeMul * 40,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: sizeMul * 15),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(3000)),
                                      border: Border.all(
                                          color: Colors.white,
                                          width: sizeMul * 2)),
                                  child: Center(
                                    child:
                                        //     TextFormField(
                                        //       // expands: true,

                                        //       maxLines: 1,

                                        //       initialValue: editReceiptScreenModel.receipt.dateTime,
                                        //   style: TextStyle(
                                        //       color: Colors.black,
                                        //       fontWeight: FontWeight.bold,
                                        //       fontSize: sizeMul * 20),

                                        //       onSaved: (input) => editReceiptScreenModel.receipt.dateTime = input,

                                        // )

                                        EditableText(
                                            autofocus: false,
                                            //  cur
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: sizeMul * 20,
                                            ),
                                            backgroundCursorColor: Colors.red,
                                            cursorColor: Colors.pinkAccent,
                                            focusNode: d_focus,
                                            onSubmitted: (a) {
                                              date_controller.text = a;
                                              // d_focus.
                                            },
                                            onSelectionChanged: (a, b) {
                                              // d_focus.unfocus();
                                              // d_focus.consumeKeyboardToken();
                                              // d_focus.dispose();
                                            },
                                            controller: date_controller),
                                  ),
                                )
                              ],
                            )),
                          )
                        ],
                      ),
                      SizedBox(
                        height: sizeMul * 12,
                      ),
                      Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: sizeMul * 8.0),
                            child: Text(
                              "CATEGORY",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: sizeMul * 14),
                            ),
                          ),
                          SizedBox(height: sizeMul * 4),
                          Container(
                              // width: sizeMul * 270,
                              height: sizeMul * 40,
                              padding: EdgeInsets.symmetric(
                                  horizontal: sizeMul * 15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3000)),
                                  border: Border.all(
                                      color: Colors.white, width: sizeMul * 2)),
                              // child: Center(
                              child: DropdownButton<String>(
                                value: catChoice,
                                items: [
                                  new DropdownMenuItem(
                                    child: Text(
                                      "Necessities",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: sizeMul * 20,
                                      ),
                                    ),
                                    value: "Necessities",
                                  ),
                                  new DropdownMenuItem(
                                    value: "Food",
                                    child: Text(
                                      "Food",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: sizeMul * 20,
                                      ),
                                    ),
                                  ),
                                  new DropdownMenuItem(
                                    value: "Transportation",
                                    child: Text(
                                      "Transportation",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: sizeMul * 20,
                                      ),
                                    ),
                                  ),
                                  new DropdownMenuItem(
                                    value: "Leisure",
                                    child: Text(
                                      "Leisure",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: sizeMul * 20,
                                      ),
                                    ),
                                  ),
                                  new DropdownMenuItem(
                                    value: "Miscellaneous",
                                    child: Text(
                                      "Miscellaneous",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: sizeMul * 20,
                                      ),
                                    ),
                                  ),
                                ],
                                onChanged: (choice) {
                                  erModel.receipt.category = choice.toString();

                                  setState(() {
                                    catChoice = choice;
                                  });

                                  editReceiptScreenModel.update();
                                },
                              )
                              // ),
                              )
                        ],
                      )),
                      Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            height: sizeMul * 35,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: sizeMul * 17),
                            child: Text(
                              "ITEMS",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: sizeMul * 20),
                            ),
                          ),
                          SizedBox(
                            height: sizeMul * 22,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: sizeMul * 18,
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.87,
                              child: Flex(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                direction: Axis.horizontal,
                                children: <Widget>[
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      "NAME",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontSize: sizeMul * 17),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   width: sizeMul * 140,
                                  // ),
                                  Text(
                                    "QTY",
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: sizeMul * 17),
                                  ),
                                  // Expanded(
                                  //   flex: 1,
                                  //   child: widget(
                                  //                                         child: Text(
                                  //       "QTY",
                                  //       overflow: TextOverflow.fade,
                                  //       style: TextStyle(
                                  //           color: Colors.white,
                                  //           fontWeight: FontWeight.w900,
                                  //           fontSize: sizeMul * 17),
                                  //     ),
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   width: sizeMul * 15,
                                  // ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      " PRICE",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontSize: sizeMul * 17),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   width: sizeMul * 15,
                                  // ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      "TOTAL",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontSize: sizeMul * 17),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Column(
                                  children: erModel.receipt.items.map((item) {
                                return ReceiptItemLine(
                                    item, editReceiptScreenModel);
                              }).toList()),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(
                                    vertical: sizeMul * 14),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(sizeMul * 35))),
                                child: OutlineButton(
                                  highlightedBorderColor: Colors.white,
                                  highlightColor: Colors.green,
                                  textColor: Colors.white,
                                  disabledBorderColor: Colors.white,
                                  color: Colors.white,
                                  borderSide: BorderSide(
                                      color: Colors.white, width: sizeMul * 2),
                                  child: Text(
                                    "+ADD",
                                    style: TextStyle(fontSize: sizeMul * 19),
                                  ),
                                  splashColor: Colors.greenAccent,
                                  highlightElevation: 5,
                                  clipBehavior: Clip.none,
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return EditItem(
                                              context,
                                              ReceiptItem("", 0, 0),
                                              true,
                                              editReceiptScreenModel);
                                        });
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: sizeMul * 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Text(
                                      "TOTAL",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20 * sizeMul,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      // "${((erModel.receipt.total.toStringAsFixed(2)))}",

                                      addCommas(int.parse(erModel.receipt.total
                                              .toStringAsFixed(2)
                                              .split('.')[0])) +
                                          ((erModel.receipt.total
                                                      .toStringAsFixed(2)
                                                      .split('.')[1] !=
                                                  null)
                                              ? ".${erModel.receipt.total.toStringAsFixed(2).split('.')[1]}"
                                              : ""),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20 * sizeMul,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: sizeMul * 40),
                                child: InkWell(
                                  onTap: () {
                                    print("llength" +
                                        erModel.receipt.items.length
                                            .toString() +
                                        "merchant" +
                                        erModel.receipt.merchant +
                                        "cat" +
                                        erModel.receipt.category);
                                    if (erModel.receipt.items.length == 0 ||
                                        erModel.receipt.merchant == "" ||
                                        erModel.receipt.category == "") {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                content: Text(
                                              "Unable to proceed because some fields are missing.",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ));
                                          });
                                    } else {
                                      erModel.saveReceipt();
                                      appModel.editReceiptScreenModel =
                                          EditReceiptScreenModel(appModel);

                                      Navigator.pushReplacement(context,
                                          CupertinoPageRoute(
                                              builder: (context) {
                                        return ShowReceiptScreen(
                                            erModel.receipt);
                                      }));
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Text(
                                        "CONTINUE",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22 * sizeMul,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: sizeMul * 12),
                                      Icon(Icons.chevron_right,
                                          size: sizeMul * 30,
                                          color: Colors.white),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }
}

class ReceiptItemLine extends StatelessWidget {
  // double price;
  TextEditingController name_controller = TextEditingController();
  TextEditingController price_controller = TextEditingController();
  TextEditingController qty_controller = TextEditingController();
  ReceiptItem receiptItem = new ReceiptItem("", 0, 0);
  EditReceiptScreenModel editReceiptScreenModel;

  // FocusNode f = FocusNode();

  ReceiptItemLine(this.receiptItem, this.editReceiptScreenModel);

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        fontSize: sizeMul * 17,
        color: Colors.white,
        fontWeight: FontWeight.w300);

    name_controller.text = receiptItem.name;
    qty_controller.text = receiptItem.qty.toString();
    price_controller.text = receiptItem.price.toString();

    return new Container(
        margin: EdgeInsets.symmetric(vertical: sizeMul * 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.87,
              // color: Colors.red,
              child: Flex(
                direction: Axis.horizontal,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Text(
                      receiptItem.name,
                      maxLines: 2,
                      style: style,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      receiptItem.qty.toString(),
                      textAlign: TextAlign.center,
                      style: style,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      addCommas(int.parse(receiptItem.price
                              .toStringAsFixed(2)
                              .split('.')[0])) +
                          ((receiptItem.price
                                      .toStringAsFixed(2)
                                      .split('.')[1] !=
                                  null)
                              ? ".${receiptItem.price.toStringAsFixed(2).split('.')[1]}"
                              : ""),
                      style: style,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      addCommas(int.parse(receiptItem.total
                              .toStringAsFixed(2)
                              .split('.')[0])) +
                          ((receiptItem.total
                                      .toStringAsFixed(2)
                                      .split('.')[1] !=
                                  null)
                              ? ".${receiptItem.total.toStringAsFixed(2).split('.')[1]}"
                              : ""),
                      style: style,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Material(
              color: Colors.white.withAlpha(0),
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(3000)),
                onTap: () {
                  // _showDialog(context, receiptItem, false);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return EditItem(context, receiptItem, false,
                            editReceiptScreenModel);
                      });
                },
                splashColor: Colors.white54,
                highlightColor: Colors.red,
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: sizeMul * 23,
                ),
              ),
            )
          ],
        ));
    ;
  }
}

class EditItem extends StatefulWidget {
  final BuildContext context;
  final ReceiptItem receiptItem;
  final bool add;
  final EditReceiptScreenModel editReceiptScreenModel;

  EditItem(
      this.context, this.receiptItem, this.add, this.editReceiptScreenModel);
  @override
  _EditItemState createState() => new _EditItemState(
      this.context, this.receiptItem, this.add, this.editReceiptScreenModel);
}

class _EditItemState extends State<EditItem> {
  BuildContext context;
  ReceiptItem receiptItem;
  EditReceiptScreenModel editReceiptScreenModel;
  bool add;
  FocusNode fa = FocusNode();
  FocusNode fb = FocusNode();
  FocusNode fc = FocusNode();

  TextEditingController name_controller = TextEditingController();
  TextEditingController qty_controller = TextEditingController();
  TextEditingController price_controller = TextEditingController();

  _EditItemState(
      this.context, this.receiptItem, this.add, this.editReceiptScreenModel);

  @override
  void initState() {
    name_controller.text = receiptItem.name;
    qty_controller.text = receiptItem.qty.toString();
    price_controller.text = receiptItem.price.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        // height: sizeMul * 300,
        // color: Colors.red,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: sizeMul * 4.0),
                  child: Text(
                    "Name",
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w900,
                        fontSize: sizeMul * 14),
                  ),
                ),
                SizedBox(height: sizeMul * 4),
                Container(
                  // width: sizeMul * 130,
                  // color: Colors.green,
                  height: sizeMul * 35,
                  padding: EdgeInsets.symmetric(horizontal: sizeMul * 15),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(3000)),
                    // border: Border.all(
                    //     color: Colors.white,
                    //     width: sizeMul * 2)
                  ),
                  child: Center(
                    child: EditableText(
                      autocorrect: false,
                      autofocus: false,
                      onChanged: (text) {
                        setState(() {
                          if (qty_controller.text == "") {
                            receiptItem.qty = 0;
                            qty_controller.text = "0";
                          }
                          if (price_controller.text == "") {
                            receiptItem.price = 0.0;
                            price_controller.text = "0.0";
                          }
                          receiptItem.name = name_controller.text;
                          receiptItem.qty = (qty_controller.text != "")
                              ? int.parse(qty_controller.text)
                              : 0;
                          receiptItem.price = (price_controller.text.length > 0)
                              ? double.parse(price_controller.text)
                              : 0.0;
                          receiptItem.total =
                              receiptItem.qty * receiptItem.price;

                          editReceiptScreenModel.changed =
                              !editReceiptScreenModel.changed;
                          editReceiptScreenModel.update();
                        });
                      },
                      selectionColor: Colors.green,
                      // textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.white, fontSize: sizeMul * 17),
                      backgroundCursorColor: Colors.red,
                      cursorColor: Colors.pinkAccent,
                      focusNode: fa,
                      controller: name_controller,
                      onSelectionChanged: (a, b) {
                        // fa.unfocus();
                        // fa.consumeKeyboardToken();
                        // fa.dispose();
                      },
                    ),
                  ),
                )
              ],
            ),
            Flex(
              mainAxisSize: MainAxisSize.max,
              direction: Axis.horizontal,
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: sizeMul * 8.0),
                        child: Text(
                          "Price",
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w900,
                              fontSize: sizeMul * 14),
                        ),
                      ),
                      SizedBox(height: sizeMul * 4),
                      Container(
                        // width: sizeMul * 130,
                        // color: Colors.green,
                        height: sizeMul * 35,
                        padding: EdgeInsets.symmetric(horizontal: sizeMul * 15),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(3000)),
                          // border: Border.all(
                          //     color: Colors.white,
                          //     width: sizeMul * 2)
                        ),
                        child: Center(
                          child: EditableText(
                            keyboardType: TextInputType.numberWithOptions(),

                            // inputType
                            onChanged: (text) {
                              setState(() {
                                if (qty_controller.text == "") {
                                  receiptItem.qty = 0;
                                  qty_controller.text = "0";
                                }
                                if (price_controller.text == "") {
                                  receiptItem.price = 0.0;
                                  price_controller.text = "0.0";
                                }
                                receiptItem.name = name_controller.text;
                                receiptItem.qty = (qty_controller.text != "")
                                    ? int.parse(qty_controller.text)
                                    : 0;
                                receiptItem.price =
                                    (price_controller.text.length > 0)
                                        ? double.parse(price_controller.text)
                                        : 0.0;
                                receiptItem.total =
                                    receiptItem.qty * receiptItem.price;

                                editReceiptScreenModel.changed =
                                    !editReceiptScreenModel.changed;
                                editReceiptScreenModel.update();
                              });
                            },
                            selectionColor: Colors.green,
                            // textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.white, fontSize: sizeMul * 17),
                            backgroundCursorColor: Colors.red,
                            cursorColor: Colors.pinkAccent,
                            focusNode: fb,
                            controller: price_controller,
                            onSelectionChanged: (a, b) {
                              // fb.unfocus();
                              // fb.consumeKeyboardToken();
                              // fb.dispose();
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: sizeMul * 10,
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: sizeMul * 8.0),
                        child: Text(
                          "Qty",
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w900,
                              fontSize: sizeMul * 14),
                        ),
                      ),
                      SizedBox(height: sizeMul * 4),
                      Container(
                        // width: sizeMul * 130,
                        // color: Colors.green,
                        height: sizeMul * 35,
                        padding: EdgeInsets.symmetric(horizontal: sizeMul * 15),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(3000)),
                          // border: Border.all(
                          //     color: Colors.white,
                          //     width: sizeMul * 2)
                        ),
                        child: Center(
                          child: EditableText(
                            keyboardType: TextInputType.numberWithOptions(),
                            onChanged: (text) {
                              setState(() {
                                if (qty_controller.text == "") {
                                  receiptItem.qty = 0;
                                  qty_controller.text = "0";
                                }
                                if (price_controller.text == "") {
                                  receiptItem.price = 0.0;
                                  price_controller.text = "0.0";
                                }
                                receiptItem.name = name_controller.text;
                                receiptItem.qty = (qty_controller.text != "")
                                    ? int.parse(qty_controller.text)
                                    : 0;
                                receiptItem.price =
                                    (price_controller.text.length > 0)
                                        ? double.parse(price_controller.text)
                                        : 0.0;
                                receiptItem.total =
                                    receiptItem.qty * receiptItem.price;

                                editReceiptScreenModel.changed =
                                    !editReceiptScreenModel.changed;
                                editReceiptScreenModel.update();
                              });
                            },
                            selectionColor: Colors.green,
                            // textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.white, fontSize: sizeMul * 17),
                            backgroundCursorColor: Colors.red,
                            cursorColor: Colors.pinkAccent,
                            focusNode: fc,
                            controller: qty_controller,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: sizeMul * 8,
            ),
            Flex(
              direction: Axis.horizontal,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text("Total: ",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: sizeMul * 18,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                // SizedBox(
                //   width: sizeMul * 27,
                // ),
                Text(
                    "${(double.parse(price_controller.text) * int.parse(qty_controller.text)).toStringAsFixed(2)}",
                    overflow: TextOverflow.fade,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: sizeMul * 18,
                        fontWeight: FontWeight.bold)),
                // SizedBox(
                //   height: sizeMul * 50,
                // ),
              ],
            ),
            SizedBox(
              height: sizeMul * 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Material(
                  child: Container(
                    height: sizeMul * 50,
                    width: sizeMul * 50,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius:
                            BorderRadius.all(Radius.circular(sizeMul * 8))),
                    child: InkWell(
                      borderRadius:
                          BorderRadius.all(Radius.circular(sizeMul * 8)),
                      onTap: () {
                        Navigator.pop(context);
                        editReceiptScreenModel
                            .removeItemFromReceipt(receiptItem);
                      },
                      splashColor: Colors.amber,
                      highlightColor: Colors.redAccent,
                      child: Icon(Icons.delete,
                          color: Colors.white, size: sizeMul * 30),
                    ),
                  ),
                ),
                SizedBox(
                  width: sizeMul * 10,
                ),
                Material(
                  child: InkWell(
                    borderRadius:
                        BorderRadius.all(Radius.circular(sizeMul * 8)),
                    splashColor: Colors.lightGreenAccent,
                    highlightColor: Colors.green,
                    onTap: () {
                      if (name_controller.text != "" &&
                          int.parse(qty_controller.text) > 0 &&
                          double.parse(price_controller.text) > 0) {
                        receiptItem.name = name_controller.text;
                        receiptItem.qty = int.parse(qty_controller.text);
                        receiptItem.price = double.parse(price_controller.text);
                        receiptItem.total = receiptItem.qty * receiptItem.price;

                        if (add) {
                          editReceiptScreenModel.addItemToReceipt(receiptItem);
                          editReceiptScreenModel.update();
                          print("added");
                        }
                        Navigator.pop(context);

                        print("WTF" +
                            editReceiptScreenModel.receipt.items[0].name +
                            editReceiptScreenModel.receipt.items[0].total
                                .toString());

                        Scaffold.of(ctx).showSnackBar(SnackBar(
                          content: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Name: ${receiptItem.name} ",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: sizeMul * 15),
                                ),
                                // Text(
                                //   "Qty: ${receiptItem.qty} ",
                                //   overflow: TextOverflow.ellipsis,
                                //   style: TextStyle(fontSize: sizeMul * 15),
                                // ),
                                // Text(
                                //   "Price: ${receiptItem.price} ",
                                //   overflow: TextOverflow.ellipsis,
                                //   style: TextStyle(fontSize: sizeMul * 15),
                                // ),
                                Text(
                                  "Total: ${receiptItem.total.toStringAsFixed(2)} ",
                                  style: TextStyle(fontSize: sizeMul * 15),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ]),
                        ));
                      }
                    },
                    child: Container(
                      height: sizeMul * 50,
                      width: sizeMul * 50,
                      decoration: BoxDecoration(
                          color: Colors.lightGreen,
                          borderRadius:
                              BorderRadius.all(Radius.circular(sizeMul * 8))),
                      child: Icon(Icons.check,
                          color: Colors.white, size: sizeMul * 30),
                    ),
                  ),
                ),
              ],
            )
            // Text("hey show up iddiot"),
          ],
        ),
      ),
    );
  }
}
