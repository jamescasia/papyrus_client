import 'package:flutter/material.dart';
import 'package:papyrus_client/screens/HomeScreen.dart';
import 'package:papyrus_client/screens/ShowReceiptScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:papyrus_client/data_models/Receipt.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget ReceiptCard(BuildContext context, Receipt receipt, index) {
  double margin = 9;
  // print("CAT IDIOT "  + receipt.category);
  Color iconColor; 

  if (receipt.category == "Transportation") iconColor = Color(0xff8ec8f8); 
  if (receipt.category == "Miscellaneous") iconColor = Color(0xffee9698); 
  if (receipt.category == "Utilities") iconColor = Color(0xffa1d2a6); 
  if (receipt.category == "Leisure") iconColor = Color(0xfffef09c); 
  if (receipt.category == "Food") iconColor = Color(0xfff4a735);

  return Container(
    // margin: EdgeInsets.only(
    //     top: sizeMulW * ((index == 0) ? 170 : (index == -1) ? 50 : (margin)),
    //     bottom: sizeMulW * margin),
    width: 333 * sizeMulW,
    height: 72 * sizeMulW,
    decoration: BoxDecoration(
        border: Border.all(color: Colors.black12, width: 1 * sizeMulW),
        color: Colors.white,
        boxShadow: [
          new BoxShadow(
            blurRadius: 2 * sizeMulW,
            color: Colors.black12,
            offset: new Offset(0, 0.4 * sizeMulW),
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(9 * sizeMulW))),
    child: InkWell(
      onTap: () {
        print("");
      },
      borderRadius: BorderRadius.all(Radius.circular(9 * sizeMulW)),
      // highlightColor: Colors.red,
      // splashColor: Colors.red,

      splashColor: Colors.amber,
      highlightColor: Colors.black.withOpacity(0.1),
      child: Material(
        color: Colors.white.withAlpha(0),
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(9 * sizeMulW)),
          onTap: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => ShowReceiptScreen(receipt)));
          },
          splashColor: Colors.amber,
          highlightColor: Colors.black.withOpacity(0.1),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: sizeMulW * 12, vertical: sizeMulW * 4),
            child: Flex(
              direction: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        (receipt.category == "Leisure")
                            ? FontAwesomeIcons.wineGlassAlt
                            : (receipt.category == "Transportation")
                                ? FontAwesomeIcons.bus
                                : (receipt.category == "Food")
                                    ? FontAwesomeIcons.utensils
                                    : (receipt.category == "Utilities")
                                        ? FontAwesomeIcons.toiletPaper
                                        : (receipt.category == "Miscellaneous")
                                            ? FontAwesomeIcons.campground
                                            : FontAwesomeIcons.file,
                        size: sizeMulW * 26,
                        color: iconColor,
                      ),
                      Flexible(
                        child: Text(
                          receipt.merchant,
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          textScaleFactor: 0.9,
                          style: TextStyle(
                              // fontSize: 11 * sizeMulW,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          receipt.items.first.name,
                          textAlign: TextAlign.center,
                          textScaleFactor: 0.9,
                          style: TextStyle(
                              // fontSize: 16 * sizeMulW,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        "" +
                            DateFormat("MMM dd, yyyy")
                                .format(DateTime.parse(receipt.dateTime)),
                                textScaleFactor: 0.85,
                        // DateTime.parse( receipt.dateTime).month.toString().substring(1,4) +" " + DateTime.parse( receipt.dateTime).day.toString() +", "+  DateTime.parse( receipt.dateTime).year.toString(),
                        // style: TextStyle(fontSize: 11 * sizeMulW),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          "${addCommas((receipt.total.floor()))}.",
                          overflow: TextOverflow.ellipsis,
                          textScaleFactor: 1 ,
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              // fontSize: 16 * sizeMulW
                              
                              ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 0),
                        child: Text(
                          // "",
                          (receipt.total.toString().split(".")[1] != "0")
                              ? "${receipt.total.toStringAsFixed(2).split(".")[1]}"
                              : "00",
                          overflow: TextOverflow.ellipsis,
                          textScaleFactor: 0.7,
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              // fontSize: 12 * sizeMulW
                              ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

// class ReceiptCard extends StatefulWidget {
//  final Receipt receipt;

//   ReceiptCard(this.receipt);

//   @override
//   _ReceiptCardState createState() => _ReceiptCardState(receipt);
// }

// class _ReceiptCardState extends State<ReceiptCard> {
//   final double margin = 6;
//   final Receipt receipt;

//   _ReceiptCardState(this.receipt);

//   @override
//   Widget build(BuildContext context) {

//     // print("" + receipt.merchant );
//     // print(receipt.dateTime);
//     // print(receipt.category);
//     // print(receipt.items[0].name);

//     return Container(

//       margin: EdgeInsets.only(top: sizeMulW * (margin), bottom:sizeMulW*margin),
//       width: 333 * sizeMulW,
//       height: 72 * sizeMulW,
//       decoration: BoxDecoration(
//           border: Border.all(color: Colors.black12, width: 1 * sizeMulW),
//           color: Colors.white,
//           boxShadow: [
//             new BoxShadow(
//               blurRadius: 2 * sizeMulW,
//               color: Colors.black12,
//               offset: new Offset(0, 0.4 * sizeMulW),
//             ),
//           ],
//           borderRadius: BorderRadius.all(Radius.circular(9 * sizeMulW))),
//       child: InkWell(
//         onTap: () {
//           print("");
//         },
//         borderRadius: BorderRadius.all(Radius.circular(9 * sizeMulW)),
//         // highlightColor: Colors.red,
//         // splashColor: Colors.red,

//         splashColor: Colors.amber,
//         highlightColor: Colors.black.withOpacity(0.1),
//         child: Material(
//           color: Colors.white.withAlpha(0),
//           child: InkWell(
//             borderRadius: BorderRadius.all(Radius.circular(9 * sizeMulW)),
//             onTap: () {
//               Navigator.push(
//                   context,
//                   CupertinoPageRoute(
//                       builder: (context) => ShowReceiptScreen(widget.receipt)));
//             },
//             splashColor: Colors.amber,
//             highlightColor: Colors.black.withOpacity(0.1),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: <Widget>[
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     Icon(Icons.image,
//                         size: MediaQuery.of(context).size.width * 0.1),
//                     Text(
//                       widget.receipt.merchant,
//                       overflow: TextOverflow.fade,
//                       style: TextStyle(
//                           fontSize: 11 * sizeMulW, fontWeight: FontWeight.w600),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Text(
//                       widget.receipt.items.first.name,
//                       style: TextStyle(
//                           fontSize: 16 * sizeMulW, fontWeight: FontWeight.w600),
//                     ),
//                     Text(
//                       DateTime.parse(widget.receipt.dateTime).month.toString().substring(1,4) +" " + DateTime.parse(widget.receipt.dateTime).day.toString() +", "+  DateTime.parse(widget.receipt.dateTime).year.toString(),
//                       style: TextStyle(fontSize: 11 * sizeMulW),
//                     )
//                   ],
//                 ),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: <Widget>[
//                     Text(
//                       "${addCommas((widget.receipt.total.floor()))}.",
//                       style: TextStyle(
//                           color: Colors.red,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 17 * sizeMulW),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(bottom: sizeMulW*1.5),
//                       child: Text(
//                         (widget.receipt.total.toString().split(".")[1] != "0")
//                             ? "${widget.receipt.total.toString().split(".")[1]}"
//                             : "00",
//                         style: TextStyle(
//                             color: Colors.red,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 11 * sizeMulW),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
