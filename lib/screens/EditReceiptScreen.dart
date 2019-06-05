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

class EditReceiptScreen extends StatefulWidget {
  @override
  _EditReceiptScreenState createState() => new _EditReceiptScreenState();
}

class _EditReceiptScreenState extends State<EditReceiptScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            // color: Colors.white,
            // child: SingleChildScrollView(
            child: EditReceiptScreenScrollPart()

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
  @override
  _EditReceiptScreenScrollPartState createState() =>
      new _EditReceiptScreenScrollPartState();
}
BuildContext ctx;
class _EditReceiptScreenScrollPartState
    extends State<EditReceiptScreenScrollPart> {
  @override
  Widget build(BuildContext context) {
    ctx = context;
    return ScopedModel<EditReceiptScreenModel>(
        model: EditReceiptScreenModel(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
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
            body: EditReceiptScreenBottomPart(),
          ),
        ));
  }
}

class EditReceiptScreenTopPart extends StatefulWidget {
  @override
  _EditReceiptScreenTopPartState createState() =>
      new _EditReceiptScreenTopPartState();
}

class _EditReceiptScreenTopPartState extends State<EditReceiptScreenTopPart> {
  static const platform = const MethodChannel('flutter.native/helper');

  void initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<EditReceiptScreenModel>(
        builder: (context, child, model) {
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
                onTap: () {},
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
    });
  }
}

class EditReceiptScreenBottomPart extends StatefulWidget {
  @override
  _EditReceiptScreenBottomPartState createState() =>
      new _EditReceiptScreenBottomPartState();
}

List<Widget> adf = [];

class _EditReceiptScreenBottomPartState
    extends State<EditReceiptScreenBottomPart> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<EditReceiptScreenModel>(
        builder: (context, child, model) {
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
                          padding:
                              EdgeInsets.symmetric(horizontal: sizeMul * 15),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3000)),
                              border: Border.all(
                                  color: Colors.white, width: sizeMul * 2)),
                          child: Center(
                            child: EditableText(
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: sizeMul * 17),
                              backgroundCursorColor: Colors.red,
                              cursorColor: Colors.pinkAccent,
                              focusNode: FocusNode(),
                              controller: model.controller,
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
                            "DATE",
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
                          padding:
                              EdgeInsets.symmetric(horizontal: sizeMul * 15),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3000)),
                              border: Border.all(
                                  color: Colors.white, width: sizeMul * 2)),
                          child: Center(
                            child: EditableText(
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: sizeMul * 17),
                                backgroundCursorColor: Colors.red,
                                cursorColor: Colors.pinkAccent,
                                focusNode: FocusNode(),
                                controller: model.controller),
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
                      padding: EdgeInsets.symmetric(horizontal: sizeMul * 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3000)),
                          border: Border.all(
                              color: Colors.white, width: sizeMul * 2)),
                      child: Center(
                          child: DropdownButtonFormField(
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
                        onChanged: null,
                      )

                          // EditableText(
                          //   textAlign: TextAlign.start,
                          //   style: TextStyle(
                          //       color: Colors.grey[800], fontSize: sizeMul * 17),
                          //   backgroundCursorColor: Colors.red,
                          //   cursorColor: Colors.pinkAccent,
                          //   focusNode: FocusNode(),
                          //   controller: TextEditingController(),
                          // ),
                          ),
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
                          print(item.name + ",");
                          return ReceiptItemLine(item, model);
                        }).toList()),

                        // ReceiptItemLine(
                        //     "Detective Pikachudddddddddddddddddddasd", 3, 500),
                        // ReceiptItemLine(
                        //     "Detective Pikachudddddddddddddddddddasd", 3, 500),
                        // ReceiptItemLine("Detective Pikachu", 3, 500),
                        // ReceiptItemLine("daffa ", 3, 500),
                        // ReceiptItemLine(
                        //     "Detective Pikachudddddddddddddddddddasd", 3, 500),
                        // ReceiptItemLine(
                        //     "Detective Pikachudddddddddddddddddddasd", 3, 500),
                        // ReceiptItemLine("Detective Pikachu", 3, 500),
                        // ReceiptItemLine("daffa ", 3, 500),
                        // Container(
                        //   width: MediaQuery.of(context).size.width,
                        //   height: sizeMul*50,
                        //   child: MaterialButton(
                        //     onPressed: null,
                        //   )
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: sizeMul * 14),
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
                              
                        print(model.receipt.items[model.receipt.items.length-1].name.toString() + "from bottom");
                              addItemAlert(context, model).show();







// TextEditingController name_controller = TextEditingController();
//   TextEditingController qty_controller = TextEditingController();
//   TextEditingController price_controller = TextEditingController();

//   ReceiptItem receiptItem = new ReceiptItem("", 0, 0);

//   return Alert(
//     context: ctx,
//     type: AlertType.none,
//     title: "",
//     // desc: "Flutter is more awesome with RFlutter Alert.",
//     content: Container(
//       width: MediaQuery.of(context).size.width * 0.88,
//       // height: sizeMul * 300,
//       // color: Colors.red,
//       child: Column(
//         mainAxisSize: MainAxisSize.max,
//         children: <Widget>[
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.max,
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.only(left: sizeMul * 8.0),
//                 child: Text(
//                   "Name",
//                   style: TextStyle(
//                       color: Colors.grey[800],
//                       fontWeight: FontWeight.w900,
//                       fontSize: sizeMul * 14),
//                 ),
//               ),
//               SizedBox(height: sizeMul * 4),
//               Container(
//                 // width: sizeMul * 130,
//                 // color: Colors.green,
//                 height: sizeMul * 35,
//                 padding: EdgeInsets.symmetric(horizontal: sizeMul * 15),
//                 decoration: BoxDecoration(
//                   color: Colors.green,
//                   borderRadius: BorderRadius.all(Radius.circular(3000)),
//                   // border: Border.all(
//                   //     color: Colors.white,
//                   //     width: sizeMul * 2)
//                 ),
//                 child: Center(
//                   child: EditableText(
//                     onChanged: (text) {
//                       receiptItem.name = name_controller.text;
//                       receiptItem.qty = int.parse(qty_controller.text);
//                       receiptItem.price = double.parse(price_controller.text);
//                       receiptItem.total = receiptItem.qty * receiptItem.price;

//                       model.update();
//                     },
//                     selectionColor: Colors.green,
//                     textAlign: TextAlign.start,
//                     style:
//                         TextStyle(color: Colors.white, fontSize: sizeMul * 17),
//                     backgroundCursorColor: Colors.red,
//                     cursorColor: Colors.pinkAccent,
//                     focusNode: FocusNode(),
//                     controller: name_controller,
//                   ),
//                 ),
//               )
//             ],
//           ),
//           Flex(
//             mainAxisSize: MainAxisSize.max,
//             direction: Axis.horizontal,
//             children: <Widget>[
//               Expanded(
//                 flex: 6,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.max,
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.only(left: sizeMul * 8.0),
//                       child: Text(
//                         "Price",
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

//                             model.update();
//                           },
//                           selectionColor: Colors.green,
//                           textAlign: TextAlign.start,
//                           style: TextStyle(
//                               color: Colors.white, fontSize: sizeMul * 17),
//                           backgroundCursorColor: Colors.red,
//                           cursorColor: Colors.pinkAccent,
//                           focusNode: FocusNode(),
//                           controller: price_controller,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 width: sizeMul * 10,
//               ),
//               Expanded(
//                 flex: 3,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.max,
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.only(left: sizeMul * 8.0),
//                       child: Text(
//                         "Qty",
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

//                             model.update();
//                           },
//                           selectionColor: Colors.green,
//                           textAlign: TextAlign.start,
//                           style: TextStyle(
//                               color: Colors.white, fontSize: sizeMul * 17),
//                           backgroundCursorColor: Colors.red,
//                           cursorColor: Colors.pinkAccent,
//                           focusNode: FocusNode(),
//                           controller: qty_controller,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: sizeMul * 8,
//           ),
//           Row(
//             mainAxisSize: MainAxisSize.max,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Text("Total",
//                   style: TextStyle(
//                     color: Colors.grey[800],
//                     fontSize: sizeMul * 18,
//                     fontWeight: FontWeight.bold,
//                   )),
//               SizedBox(
//                 width: sizeMul * 27,
//               ),

//               Text("${receiptItem.total}",
//                   style: TextStyle(
//                       color: Colors.grey[800],
//                       fontSize: sizeMul * 18,
//                       fontWeight: FontWeight.bold)),
//               SizedBox(
//                 height: sizeMul * 50,
//               ),
//               Material(
//                 child: Container(
//                   height: sizeMul * 50,
//                   width: sizeMul * 50,
//                   decoration: BoxDecoration(
//                       color: Colors.red,
//                       borderRadius:
//                           BorderRadius.all(Radius.circular(sizeMul * 8))),
//                   child: InkWell(
//                     onTap: () {
//                       Navigator.pop(context);
//                       model.removeItemFromReceipt(receiptItem);
//                     },
//                     splashColor: Colors.amber,
//                     highlightColor: Colors.redAccent,
//                     child: Icon(Icons.delete,
//                         color: Colors.white, size: sizeMul * 30),
//                   ),
//                 ),
//               ),
//               Material(
//                 child: InkWell(
//                   splashColor: Colors.lightGreenAccent,
//                   highlightColor: Colors.green,
//                   onTap: () {
//                     receiptItem.name = name_controller.text;
//                     receiptItem.qty = int.parse(qty_controller.text);
//                     receiptItem.price = double.parse(price_controller.text);
//                     receiptItem.total = receiptItem.qty * receiptItem.price;
//                     model.changed = !model.changed;

//                     model.addItemToReceipt(receiptItem);
//                     // ScopedModelDescendant.
//                     // model.receipt.addReceiptItem(receiptItem);
//                     // model.notifyListeners();

//                     print(model.receipt.items[model.receipt.items.length-1].name.toString() + "from somewhere");
//                     // model.update();
//                     Navigator.pop(context);
//                     print('actually predafssed');

//                     Scaffold.of(ctx).showSnackBar(SnackBar(
//                       content: Text(model
//                           .receipt.items[model.receipt.items.length - 1].name),
//                     ));
//                   },
//                   child: Container(
//                     height: sizeMul * 50,
//                     width: sizeMul * 50,
//                     decoration: BoxDecoration(
//                         color: Colors.lightGreen,
//                         borderRadius:
//                             BorderRadius.all(Radius.circular(sizeMul * 8))),
//                     child: Icon(Icons.check,
//                         color: Colors.white, size: sizeMul * 30),
//                   ),
//                 ),
//               ),
//               // IconButton(
//               //   iconSize: sizeMul*40,
//               //   icon: Icon(
//               //     Icons.delete,
//               //     color: Colors.white,
//               //     size: sizeMul * 50,
//               //   ),
//               //   color: Colors.red,
//               //   onPressed: (){},
//               // ),
//               // IconButton(
//               //     icon: Icon(Icons.check,
//               //         color: Colors.white, size: sizeMul * 50),
//               //     color: Colors.lightGreen,
//               //     onPressed:  (){}),
//             ],
//           ),
//           // Text("hey show up iddiot"),
//         ],
//       ),
//     ),
//     buttons: [
//       DialogButton(
//         width: 0,
//         height: 0,
//         color: Colors.red,
//         child: Icon(
//           Icons.recent_actors,
//           color: Colors.white,
//         ),
//       ),
//       // DialogButton(
//       //   child: Text(
//       //     "DONE",
//       //     style: TextStyle(color: Colors.white, fontSize: 20),
//       //   ),
//       //   onPressed: () {
//       //     Navigator.pop(context);
//       //     name = name_controller.text;
//       //     qty = int.parse(qty_controller.text);
//       //     price = double.parse(price_controller.text);
//       //     total = qty * price;
//       //     setState(() {});
//       //   },
//       //   width: 120,
//       // )
//     ],
//   ).show();














                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: sizeMul * 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                "${addCommas(3000)}",
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
                                  size: sizeMul * 30, color: Colors.white),
                            ],
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
                        receiptItem.price.toString(),
                        style: style,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        receiptItem.total.toString(),
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
                    Alert(
                      context: context,
                      type: AlertType.none,
                      title: "",
                      // desc: "Flutter is more awesome with RFlutter Alert.",
                      content: Container(
                        width: MediaQuery.of(context).size.width * 0.88,
                        // height: sizeMul * 300,
                        // color: Colors.red,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal: sizeMul * 15),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(3000)),
                                    // border: Border.all(
                                    //     color: Colors.white,
                                    //     width: sizeMul * 2)
                                  ),
                                  child: Center(
                                    child: EditableText(
                                      onChanged: (text) {
                                        receiptItem.name = name_controller.text;
                                        receiptItem.qty =
                                            int.parse(qty_controller.text);
                                        receiptItem.price =
                                            double.parse(price_controller.text);
                                        receiptItem.total =
                                            receiptItem.qty * receiptItem.price;

                                        model.update();
                                      },
                                      selectionColor: Colors.green,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: sizeMul * 17),
                                      backgroundCursorColor: Colors.red,
                                      cursorColor: Colors.pinkAccent,
                                      focusNode: FocusNode(),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: sizeMul * 8.0),
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: sizeMul * 15),
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(3000)),
                                          // border: Border.all(
                                          //     color: Colors.white,
                                          //     width: sizeMul * 2)
                                        ),
                                        child: Center(
                                          child: EditableText(
                                            onChanged: (text) {
                                              receiptItem.name =
                                                  name_controller.text;
                                              receiptItem.qty = int.parse(
                                                  qty_controller.text);
                                              receiptItem.price = double.parse(
                                                  price_controller.text);
                                              receiptItem.total =
                                                  receiptItem.qty *
                                                      receiptItem.price;

                                              model.update();
                                            },
                                            selectionColor: Colors.green,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: sizeMul * 17),
                                            backgroundCursorColor: Colors.red,
                                            cursorColor: Colors.pinkAccent,
                                            focusNode: FocusNode(),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: sizeMul * 8.0),
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: sizeMul * 15),
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(3000)),
                                          // border: Border.all(
                                          //     color: Colors.white,
                                          //     width: sizeMul * 2)
                                        ),
                                        child: Center(
                                          child: EditableText(
                                            onChanged: (text) {
                                              receiptItem.name =
                                                  name_controller.text;
                                              receiptItem.qty = int.parse(
                                                  qty_controller.text);
                                              receiptItem.price = double.parse(
                                                  price_controller.text);
                                              receiptItem.total =
                                                  receiptItem.qty *
                                                      receiptItem.price;

                                              model.update();
                                            },
                                            selectionColor: Colors.green,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: sizeMul * 17),
                                            backgroundCursorColor: Colors.red,
                                            cursorColor: Colors.pinkAccent,
                                            focusNode: FocusNode(),
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
                                Text("Total",
                                    style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: sizeMul * 18,
                                      fontWeight: FontWeight.bold,
                                    )),
                                SizedBox(
                                  width: sizeMul * 27,
                                ),

                                Text("${receiptItem.total}",
                                    style: TextStyle(
                                        color: Colors.grey[800],
                                        fontSize: sizeMul * 18,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: sizeMul * 50,
                                ),
                                Material(
                                  child: Container(
                                    height: sizeMul * 50,
                                    width: sizeMul * 50,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(sizeMul * 8))),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        model
                                            .removeItemFromReceipt(receiptItem);
                                        // model.receipt
                                        //     .removeReceiptItem(receiptItem);
                                      },
                                      splashColor: Colors.amber,
                                      highlightColor: Colors.redAccent,
                                      child: Icon(Icons.delete,
                                          color: Colors.white,
                                          size: sizeMul * 30),
                                    ),
                                  ),
                                ),
                                Material(
                                  child: InkWell(
                                    splashColor: Colors.lightGreenAccent,
                                    highlightColor: Colors.green,
                                    onTap: () {
                                      print("hello");
                                      receiptItem.name = name_controller.text;
                                      receiptItem.qty =
                                          int.parse(qty_controller.text);
                                      receiptItem.price =
                                          double.parse(price_controller.text);
                                      receiptItem.total =
                                          receiptItem.qty * receiptItem.price;

                                      model.update();

                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: sizeMul * 50,
                                      width: sizeMul * 50,
                                      decoration: BoxDecoration(
                                          color: Colors.lightGreen,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(sizeMul * 8))),
                                      child: Icon(Icons.check,
                                          color: Colors.white,
                                          size: sizeMul * 30),
                                    ),
                                  ),
                                ),
                                // IconButton(
                                //   iconSize: sizeMul*40,
                                //   icon: Icon(
                                //     Icons.delete,
                                //     color: Colors.white,
                                //     size: sizeMul * 50,
                                //   ),
                                //   color: Colors.red,
                                //   onPressed: (){},
                                // ),
                                // IconButton(
                                //     icon: Icon(Icons.check,
                                //         color: Colors.white, size: sizeMul * 50),
                                //     color: Colors.lightGreen,
                                //     onPressed:  (){}),
                              ],
                            ),
                            // Text("hey show up iddiot"),
                          ],
                        ),
                      ),
                      buttons: [
                        DialogButton(
                          width: 0,
                          height: 0,
                          color: Colors.red,
                          child: Icon(
                            Icons.radio,
                            color: Colors.white,
                          ),
                        ),
                        // DialogButton(
                        //   child: Text(
                        //     "DONE",
                        //     style: TextStyle(color: Colors.white, fontSize: 20),
                        //   ),
                        //   onPressed: () {
                        //     Navigator.pop(context);
                        //     name = name_controller.text;
                        //     qty = int.parse(qty_controller.text);
                        //     price = double.parse(price_controller.text);
                        //     total = qty * price;
                        //     setState(() {});
                        //   },
                        //   width: 120,
                        // )
                      ],
                    ).show();
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

Alert addItemAlert(BuildContext context, EditReceiptScreenModel model) {

  print(model.receipt.items[model.receipt.items.length-1].name.toString() + "from additemalert");
  TextEditingController name_controller = TextEditingController();
  TextEditingController qty_controller = TextEditingController();
  TextEditingController price_controller = TextEditingController();

  ReceiptItem receiptItem = new ReceiptItem("", 0, 0);

  return Alert(
    context: ctx,
    type: AlertType.none,
    title: "",
    // desc: "Flutter is more awesome with RFlutter Alert.",
    content: Container(
      width: MediaQuery.of(context).size.width * 0.88,
      // height: sizeMul * 300,
      // color: Colors.red,
      child: Column(
        mainAxisSize: MainAxisSize.max,
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
                      receiptItem.name = name_controller.text;
                      receiptItem.qty = int.parse(qty_controller.text);
                      receiptItem.price = double.parse(price_controller.text);
                      receiptItem.total = receiptItem.qty * receiptItem.price;

                      model.update();
                    },
                    selectionColor: Colors.green,
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(color: Colors.white, fontSize: sizeMul * 17),
                    backgroundCursorColor: Colors.red,
                    cursorColor: Colors.pinkAccent,
                    focusNode: FocusNode(),
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
                            receiptItem.name = name_controller.text;
                            receiptItem.qty = int.parse(qty_controller.text);
                            receiptItem.price =
                                double.parse(price_controller.text);
                            receiptItem.total =
                                receiptItem.qty * receiptItem.price;

                            model.update();
                          },
                          selectionColor: Colors.green,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white, fontSize: sizeMul * 17),
                          backgroundCursorColor: Colors.red,
                          cursorColor: Colors.pinkAccent,
                          focusNode: FocusNode(),
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
                            receiptItem.name = name_controller.text;
                            receiptItem.qty = int.parse(qty_controller.text);
                            receiptItem.price =
                                double.parse(price_controller.text);
                            receiptItem.total =
                                receiptItem.qty * receiptItem.price;

                            model.update();
                          },
                          selectionColor: Colors.green,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white, fontSize: sizeMul * 17),
                          backgroundCursorColor: Colors.red,
                          cursorColor: Colors.pinkAccent,
                          focusNode: FocusNode(),
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
              Text("Total",
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: sizeMul * 18,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(
                width: sizeMul * 27,
              ),

              Text("${receiptItem.total}",
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: sizeMul * 18,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: sizeMul * 50,
              ),
              Material(
                child: Container(
                  height: sizeMul * 50,
                  width: sizeMul * 50,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius:
                          BorderRadius.all(Radius.circular(sizeMul * 8))),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      model.removeItemFromReceipt(receiptItem);
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
                  splashColor: Colors.lightGreenAccent,
                  highlightColor: Colors.green,
                  onTap: () {
                    receiptItem.name = name_controller.text;
                    receiptItem.qty = int.parse(qty_controller.text);
                    receiptItem.price = double.parse(price_controller.text);
                    receiptItem.total = receiptItem.qty * receiptItem.price;
                    model.changed = !model.changed;

                    model.addItemToReceipt(receiptItem);
                    // ScopedModelDescendant.
                    // model.receipt.addReceiptItem(receiptItem);
                    // model.notifyListeners();

                    print(model.receipt.items[model.receipt.items.length-1].name.toString() + "from somewhere");
                    // model.update();
                    Navigator.pop(context);
                    print('actually predafssed');

                    Scaffold.of(ctx).showSnackBar(SnackBar(
                      content: Text(model
                          .receipt.items[model.receipt.items.length - 1].name),
                    ));
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
              // IconButton(
              //   iconSize: sizeMul*40,
              //   icon: Icon(
              //     Icons.delete,
              //     color: Colors.white,
              //     size: sizeMul * 50,
              //   ),
              //   color: Colors.red,
              //   onPressed: (){},
              // ),
              // IconButton(
              //     icon: Icon(Icons.check,
              //         color: Colors.white, size: sizeMul * 50),
              //     color: Colors.lightGreen,
              //     onPressed:  (){}),
            ],
          ),
          // Text("hey show up iddiot"),
        ],
      ),
    ),
    buttons: [
      DialogButton(
        width: 0,
        height: 0,
        color: Colors.red,
        child: Icon(
          Icons.recent_actors,
          color: Colors.white,
        ),
      ),
      // DialogButton(
      //   child: Text(
      //     "DONE",
      //     style: TextStyle(color: Colors.white, fontSize: 20),
      //   ),
      //   onPressed: () {
      //     Navigator.pop(context);
      //     name = name_controller.text;
      //     qty = int.parse(qty_controller.text);
      //     price = double.parse(price_controller.text);
      //     total = qty * price;
      //     setState(() {});
      //   },
      //   width: 120,
      // )
    ],
  );
}
