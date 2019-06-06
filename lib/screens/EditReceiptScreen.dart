import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'package:papyrus_client/helpers/ClipShadowPath.dart';
import 'package:papyrus_client/helpers/CustomShapeClipper.dart';
import 'package:papyrus_client/helpers/ReceiptCard.dart';
import 'package:zoomable_image/zoomable_image.dart';
import 'package:android_intent/android_intent.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:papyrus_client/models/EditReceiptScreenModel.dart';
import 'package:papyrus_client/data_models/Receipt.dart';
import 'dart:core';
import 'package:papyrus_client/models/AppModel.dart';
// import ''
// import 'dart:core';

EditReceiptScreenModel edrsm ;
class EditReceiptScreen extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
        // color: Colors.white,
        // child: SingleChildScrollView(
        child: ScopedModelDescendant<AppModel>(
            builder: (context, child, appModel) {

              edrsm = appModel.editReceiptScreenModel;
      return EditReceiptScreenScrollPart(appModel);
    })

        // Column(
        //   children: <Widget>[
        //     EditReceiptScreenTopPart()
        //     // , EditReceiptScreenBottomPart()
        //   ],
        //   // ),
        // ),

        ));
  }
}

class EditReceiptScreenScrollPart extends StatefulWidget {
  final AppModel appModel;

  EditReceiptScreenScrollPart(this.appModel);
  @override
  _EditReceiptScreenScrollPartState createState() =>
      new _EditReceiptScreenScrollPartState(appModel);
}

BuildContext ctx;

class _EditReceiptScreenScrollPartState
    extends State<EditReceiptScreenScrollPart> {
  AppModel appModel;
  _EditReceiptScreenScrollPartState(this.appModel);

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
        body: EditReceiptScreenBottomPart(appModel),
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
        background: Stack(
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
              new AssetImage("assets/pictures/receipt-sample.jpg"),
              backgroundColor: Colors.grey[700],
            )),
        Positioned(
          left: sizeMul * 1,
          top: sizeMul * 24,
          child: InkWell(
            splashColor: Colors.white.withAlpha(0),
            highlightColor: Colors.black.withOpacity(0.1),
            // ,
            onTap: () {
              edrsm = EditReceiptScreenModel();
              Navigator.pop(context);
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
          right: 48 * sizeMul * sizeMul,
          child: Material(
            color: Colors.white.withOpacity(0),
            borderRadius: BorderRadius.all(Radius.circular(3000)),
            child: InkWell(
              radius: sizeMul * 24,
              splashColor: Colors.white.withAlpha(0),
              highlightColor: Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.all(Radius.circular(3000)),
              onTap: () {
                // edrsm = EditReceiptScreenModel();
                // edrsm.changed=!edrsm.changed;
                // edrsm.update();
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
    ));
  }
}


class EditReceiptScreenBottomPart extends StatelessWidget {

  AppModel appModel;
  EditReceiptScreenBottomPart(this.appModel);
  @override
  Widget build(BuildContext context) {
    // ScopedModelDescendant

    TextEditingController merchant_controller = TextEditingController();
    TextEditingController date_controller = TextEditingController();
    merchant_controller.text = edrsm.receipt.merchant;
    date_controller.text = edrsm.receipt.dateTime;
    FocusNode m_focus = FocusNode();
    FocusNode d_focus = FocusNode();
    // FocusNode
    return ScopedModel<EditReceiptScreenModel>(
        model: edrsm,
        child: ScopedModelDescendant<EditReceiptScreenModel>(
            rebuildOnChange: true,
            builder: (context, child, model) {
              
              ctx = context;
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
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
                                  width: sizeMul * 200,
                                  height: sizeMul * 35,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: sizeMul * 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(3000)),
                                      border: Border.all(
                                          color: Colors.white,
                                          width: sizeMul * 2)),
                                  child: Center(
                                    child: EditableText(
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: sizeMul * 17),
                                      backgroundCursorColor: Colors.red,
                                      cursorColor: Colors.pinkAccent,
                                      focusNode: m_focus,
                                      controller: merchant_controller,
                                    ),
                                  ),
                                )
                              ],
                            )),
                            SizedBox(
                              width: sizeMul * 20,
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
                                    "DATE & TIME",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: sizeMul * 14),
                                  ),
                                ),
                                SizedBox(height: sizeMul * 4),
                                Container(
                                  width: sizeMul * 130,
                                  height: sizeMul * 35,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: sizeMul * 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(3000)),
                                      border: Border.all(
                                          color: Colors.white,
                                          width: sizeMul * 2)),
                                  child: Center(
                                    child: EditableText(
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: sizeMul * 17),
                                        backgroundCursorColor: Colors.red,
                                        cursorColor: Colors.pinkAccent,
                                        focusNode: d_focus,
                                        controller: date_controller),
                                  ),
                                )
                              ],
                            ))
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
                                width: sizeMul * 270,
                                height: sizeMul * 35,
                                padding: EdgeInsets.symmetric(
                                    horizontal: sizeMul * 15),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(3000)),
                                    border: Border.all(
                                        color: Colors.white,
                                        width: sizeMul * 2)),
                                // child: Center(
                                child: DropdownButtonFormField(
                                  // value:model.receipt.category,

                                  items: [
                                    new DropdownMenuItem(
                                      child: Text("Entertainment"),
                                      value: 50,
                                    ),
                                    new DropdownMenuItem(
                                      value: 75,
                                      child: Text("Food"),
                                    ),
                                    new DropdownMenuItem(
                                      value: 100,
                                      child: Text("Fuel"),
                                    ),
                                    new DropdownMenuItem(
                                      value: 200,
                                      child: Text("Transportation"),
                                    ),
                                    new DropdownMenuItem(
                                      value: 500,
                                      child: Text("Necessities"),
                                    ),
                                    new DropdownMenuItem(
                                      value: 1000,
                                      child: Text("Misc."),
                                    ),
                                  ],
                                  onChanged: (choice) {
                                    model.receipt.category = choice.toString();
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
                                      flex: 5,
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
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "QTY",
                                        overflow: TextOverflow.fade,
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
                                      flex: 2,
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

                                    // children: model.receipt.items
                                    //     .map((item) => ReceiptItemLine(item))
                                    //     .toList()),
                                    children: model.receipt.items.map((item) {
                                  return ReceiptItemLine(item, model);
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
                                        color: Colors.white,
                                        width: sizeMul * 2),
                                    child: Text(
                                      "+ADD",
                                      style: TextStyle(fontSize: sizeMul * 19),
                                    ),
                                    splashColor: Colors.greenAccent,
                                    highlightElevation: 5,
                                    clipBehavior: Clip.none,
                                    onPressed: () {
                                      // ReceiptItem receiptItem =
                                      //     ReceiptItem("Im Mina", 1999, 2018);

                                      //     model.addItemToReceipt(receiptItem);

                                      // print(model
                                      //         .receipt
                                      //         .items[
                                      //             model.receipt.items.length -
                                      //                 1]
                                      //         .name
                                      //         .toString() +
                                      //     "from bottom");
                                      // addItemAlert(ctx, model);
                                      // _showDialog(
                                      //     ctx, ReceiptItem("", 0, 0), true);

                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return EditItem(context,
                                                ReceiptItem("", 0, 0), true);
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
                                        "${((model.receipt.total.toStringAsFixed(2)))}",
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
                                      edrsm.saveReceiptToJson();
                                      edrsm = EditReceiptScreenModel();
                                      Navigator.pop(context);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
            }));
  }
}

class ReceiptItemLine extends StatelessWidget {
  // double price;
  TextEditingController name_controller = TextEditingController();
  TextEditingController price_controller = TextEditingController();
  TextEditingController qty_controller = TextEditingController();
  ReceiptItem receiptItem = new ReceiptItem("", 0, 0);
  EditReceiptScreenModel model;

  // FocusNode f = FocusNode();

  ReceiptItemLine(this.receiptItem, this.model);

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
              child: Flex(
                direction: Axis.horizontal,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 5,
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
                      style: style,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      receiptItem.price.toStringAsFixed(2),
                      style: style,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      receiptItem.total.toStringAsFixed(2),
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
                onTap: () {
                  // _showDialog(context, receiptItem, false);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return EditItem(context, receiptItem, false);
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
  EditItem(this.context, this.receiptItem, this.add);
  @override
  _EditItemState createState() =>
      new _EditItemState(this.context, this.receiptItem, this.add);
}

class _EditItemState extends State<EditItem> {
  BuildContext context;
  ReceiptItem receiptItem;
  bool add;
  FocusNode fa = FocusNode();
  FocusNode fb = FocusNode();
  FocusNode fc = FocusNode();
  _EditItemState(this.context, this.receiptItem, this.add);
  @override
  Widget build(BuildContext context) {
    TextEditingController name_controller = TextEditingController();
    TextEditingController qty_controller = TextEditingController();
    TextEditingController price_controller = TextEditingController();
    name_controller.text = receiptItem.name;
    qty_controller.text = receiptItem.qty.toString();
    price_controller.text = receiptItem.price.toString();

    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width * 0.88,
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
                  padding: EdgeInsets.only(left: sizeMul * 8.0),
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
                      onChanged: (text) {
                        setState(() {
                          receiptItem.name = name_controller.text;
                          receiptItem.qty = int.parse(qty_controller.text);
                          receiptItem.price =
                              double.parse(price_controller.text);
                          receiptItem.total =
                              receiptItem.qty * receiptItem.price;
                          edrsm.changed = !edrsm.changed;

                          edrsm.update();
                        });
                      },
                      selectionColor: Colors.green,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.white, fontSize: sizeMul * 17),
                      backgroundCursorColor: Colors.red,
                      cursorColor: Colors.pinkAccent,
                      focusNode: fa,
                      controller: name_controller,
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
                            onChanged: (text) {
                              setState(() {
                                receiptItem.name = name_controller.text;
                                receiptItem.qty =
                                    int.parse(qty_controller.text);
                                receiptItem.price =
                                    double.parse(price_controller.text);
                                receiptItem.total =
                                    receiptItem.qty * receiptItem.price;

                                edrsm.changed = !edrsm.changed;
                                edrsm.update();
                              });
                            },
                            selectionColor: Colors.green,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.white, fontSize: sizeMul * 17),
                            backgroundCursorColor: Colors.red,
                            cursorColor: Colors.pinkAccent,
                            focusNode: fb,
                            controller: price_controller,
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
                            onChanged: (text) {
                              setState(() {
                                receiptItem.name = name_controller.text;
                                receiptItem.qty =
                                    int.parse(qty_controller.text);
                                receiptItem.price =
                                    double.parse(price_controller.text);
                                receiptItem.total =
                                    receiptItem.qty * receiptItem.price;
                                edrsm.changed = !edrsm.changed;
                                edrsm.update();
                              });
                            },
                            selectionColor: Colors.green,
                            textAlign: TextAlign.start,
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
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Total: ",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: sizeMul * 18,
                      fontWeight: FontWeight.bold,
                    )),
                // SizedBox(
                //   width: sizeMul * 27,
                // ),
                Container(
                  width: sizeMul * 120,
                  child: Text(
                      "${(double.parse(price_controller.text) * int.parse(qty_controller.text)).toStringAsFixed(2)}",
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: sizeMul * 18,
                          fontWeight: FontWeight.bold)),
                ),
                // SizedBox(
                //   height: sizeMul * 50,
                // ),
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
                        edrsm.removeItemFromReceipt(receiptItem);
                      },
                      splashColor: Colors.amber,
                      highlightColor: Colors.redAccent,
                      child: Icon(Icons.delete,
                          color: Colors.white, size: sizeMul * 30),
                    ),
                  ),
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
                          edrsm.addItemToReceipt(receiptItem);
                        }
                        Navigator.pop(context);

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
            ),
            // Text("hey show up iddiot"),
          ],
        ),
      ),
    );
  }
}

// void _showDialog(BuildContext context, ReceiptItem receiptItem, bool add) {
//   showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         TextEditingController name_controller = TextEditingController();
//         TextEditingController qty_controller = TextEditingController();
//         TextEditingController price_controller = TextEditingController();

//         name_controller.text = receiptItem.name;
//         qty_controller.text = receiptItem.qty.toString();
//         price_controller.text = receiptItem.price.toString();

//         // ReceiptItem receiptItem = ReceiptItem("", 0, 0);
//         return AlertDialog(
//           content: Container(
//             width: MediaQuery.of(context).size.width * 0.88,
//             // height: sizeMul * 300,
//             // color: Colors.red,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.max,
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.only(left: sizeMul * 8.0),
//                       child: Text(
//                         "Name",
//                         style: TextStyle(
//                             color: Colors.grey[800],
//                             fontWeight: FontWeight.w900,
//                             fontSize: sizeMul * 14),
//                       ),
//                     ),
//                     SizedBox(height: sizeMul * 4),
//                     Container(
//                       // width: sizeMul * 130,
//                       // color: Colors.green,
//                       height: sizeMul * 35,
//                       padding: EdgeInsets.symmetric(horizontal: sizeMul * 15),
//                       decoration: BoxDecoration(
//                         color: Colors.green,
//                         borderRadius: BorderRadius.all(Radius.circular(3000)),
//                         // border: Border.all(
//                         //     color: Colors.white,
//                         //     width: sizeMul * 2)
//                       ),
//                       child: Center(
//                         child: EditableText(
//                           onChanged: (text) {
//                             receiptItem.name = name_controller.text;
//                             receiptItem.qty = int.parse(qty_controller.text);
//                             receiptItem.price =
//                                 double.parse(price_controller.text);
//                             receiptItem.total =
//                                 receiptItem.qty * receiptItem.price;
//                             edrsm.changed = !edrsm.changed;

//                             edrsm.update();
//                           },
//                           selectionColor: Colors.green,
//                           textAlign: TextAlign.start,
//                           style: TextStyle(
//                               color: Colors.white, fontSize: sizeMul * 17),
//                           backgroundCursorColor: Colors.red,
//                           cursorColor: Colors.pinkAccent,
//                           focusNode: FocusNode(),
//                           controller: name_controller,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//                 Flex(
//                   mainAxisSize: MainAxisSize.max,
//                   direction: Axis.horizontal,
//                   children: <Widget>[
//                     Expanded(
//                       flex: 6,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.max,
//                         children: <Widget>[
//                           Padding(
//                             padding: EdgeInsets.only(left: sizeMul * 8.0),
//                             child: Text(
//                               "Price",
//                               style: TextStyle(
//                                   color: Colors.grey[800],
//                                   fontWeight: FontWeight.w900,
//                                   fontSize: sizeMul * 14),
//                             ),
//                           ),
//                           SizedBox(height: sizeMul * 4),
//                           Container(
//                             // width: sizeMul * 130,
//                             // color: Colors.green,
//                             height: sizeMul * 35,
//                             padding:
//                                 EdgeInsets.symmetric(horizontal: sizeMul * 15),
//                             decoration: BoxDecoration(
//                               color: Colors.green,
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(3000)),
//                               // border: Border.all(
//                               //     color: Colors.white,
//                               //     width: sizeMul * 2)
//                             ),
//                             child: Center(
//                               child: EditableText(
//                                 onChanged: (text) {
//                                   receiptItem.name = name_controller.text;
//                                   receiptItem.qty =
//                                       int.parse(qty_controller.text);
//                                   receiptItem.price =
//                                       double.parse(price_controller.text);
//                                   receiptItem.total =
//                                       receiptItem.qty * receiptItem.price;

//                                   edrsm.changed = !edrsm.changed;
//                                   edrsm.update();
//                                 },
//                                 selectionColor: Colors.green,
//                                 textAlign: TextAlign.start,
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: sizeMul * 17),
//                                 backgroundCursorColor: Colors.red,
//                                 cursorColor: Colors.pinkAccent,
//                                 focusNode: FocusNode(),
//                                 controller: price_controller,
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       width: sizeMul * 10,
//                     ),
//                     Expanded(
//                       flex: 3,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.max,
//                         children: <Widget>[
//                           Padding(
//                             padding: EdgeInsets.only(left: sizeMul * 8.0),
//                             child: Text(
//                               "Qty",
//                               style: TextStyle(
//                                   color: Colors.grey[800],
//                                   fontWeight: FontWeight.w900,
//                                   fontSize: sizeMul * 14),
//                             ),
//                           ),
//                           SizedBox(height: sizeMul * 4),
//                           Container(
//                             // width: sizeMul * 130,
//                             // color: Colors.green,
//                             height: sizeMul * 35,
//                             padding:
//                                 EdgeInsets.symmetric(horizontal: sizeMul * 15),
//                             decoration: BoxDecoration(
//                               color: Colors.green,
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(3000)),
//                               // border: Border.all(
//                               //     color: Colors.white,
//                               //     width: sizeMul * 2)
//                             ),
//                             child: Center(
//                               child: EditableText(
//                                 onChanged: (text) {
//                                   receiptItem.name = name_controller.text;
//                                   receiptItem.qty =
//                                       int.parse(qty_controller.text);
//                                   receiptItem.price =
//                                       double.parse(price_controller.text);
//                                   receiptItem.total =
//                                       receiptItem.qty * receiptItem.price;
//                                   edrsm.changed = !edrsm.changed;
//                                   edrsm.update();
//                                 },
//                                 selectionColor: Colors.green,
//                                 textAlign: TextAlign.start,
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: sizeMul * 17),
//                                 backgroundCursorColor: Colors.red,
//                                 cursorColor: Colors.pinkAccent,
//                                 focusNode: FocusNode(),
//                                 controller: qty_controller,
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: sizeMul * 8,
//                 ),
//                 Row(
//                   mainAxisSize: MainAxisSize.max,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Text("Total",
//                         style: TextStyle(
//                           color: Colors.grey[800],
//                           fontSize: sizeMul * 18,
//                           fontWeight: FontWeight.bold,
//                         )),
//                     SizedBox(
//                       width: sizeMul * 27,
//                     ),
//                     Text(
//                         "${double.parse(price_controller.text) * int.parse(qty_controller.text)}",
//                         style: TextStyle(
//                             color: Colors.grey[800],
//                             fontSize: sizeMul * 18,
//                             fontWeight: FontWeight.bold)),
//                     SizedBox(
//                       height: sizeMul * 50,
//                     ),
//                     Material(
//                       child: Container(
//                         height: sizeMul * 50,
//                         width: sizeMul * 50,
//                         decoration: BoxDecoration(
//                             color: Colors.red,
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(sizeMul * 8))),
//                         child: InkWell(
//                           borderRadius:
//                               BorderRadius.all(Radius.circular(sizeMul * 8)),
//                           onTap: () {
//                             Navigator.pop(context);
//                             edrsm.removeItemFromReceipt(receiptItem);
//                           },
//                           splashColor: Colors.amber,
//                           highlightColor: Colors.redAccent,
//                           child: Icon(Icons.delete,
//                               color: Colors.white, size: sizeMul * 30),
//                         ),
//                       ),
//                     ),
//                     Material(
//                       child: InkWell(
//                         borderRadius:
//                             BorderRadius.all(Radius.circular(sizeMul * 8)),
//                         splashColor: Colors.lightGreenAccent,
//                         highlightColor: Colors.green,
//                         onTap: () {
//                           if (name_controller.text != "" &&
//                               int.parse(qty_controller.text) > 0 &&
//                               double.parse(price_controller.text) > 0) {
//                             receiptItem.name = name_controller.text;
//                             receiptItem.qty = int.parse(qty_controller.text);
//                             receiptItem.price =
//                                 double.parse(price_controller.text);
//                             receiptItem.total =
//                                 receiptItem.qty * receiptItem.price;

//                             if (add) {
//                               edrsm.addItemToReceipt(receiptItem);
//                             }
//                             Navigator.pop(context);

//                             Scaffold.of(ctx).showSnackBar(SnackBar(
//                               content: Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: <Widget>[
//                                     Text(
//                                       "Name: ${receiptItem.name} ",
//                                       overflow: TextOverflow.ellipsis,
//                                       style: TextStyle(fontSize: sizeMul * 15),
//                                     ),
//                                     Text(
//                                       "Qty: ${receiptItem.qty} ",
//                                       overflow: TextOverflow.ellipsis,
//                                       style: TextStyle(fontSize: sizeMul * 15),
//                                     ),
//                                     Text(
//                                       "Price: ${receiptItem.price} ",
//                                       overflow: TextOverflow.ellipsis,
//                                       style: TextStyle(fontSize: sizeMul * 15),
//                                     ),
//                                     Text(
//                                       "Total: ${receiptItem.total} ",
//                                       style: TextStyle(fontSize: sizeMul * 15),
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ]),
//                             ));
//                           }
//                         },
//                         child: Container(
//                           height: sizeMul * 50,
//                           width: sizeMul * 50,
//                           decoration: BoxDecoration(
//                               color: Colors.lightGreen,
//                               borderRadius: BorderRadius.all(
//                                   Radius.circular(sizeMul * 8))),
//                           child: Icon(Icons.check,
//                               color: Colors.white, size: sizeMul * 30),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 // Text("hey show up iddiot"),
//               ],
//             ),
//           ),
//         );
//       });
// }
