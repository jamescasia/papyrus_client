import 'package:flutter/material.dart';
import 'package:papyrus_client/screens/HomeScreen.dart';
import 'package:papyrus_client/screens/ShowReceiptScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:papyrus_client/data_models/Receipt.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReceiptCardPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
        color: Colors.black12,
        gap: 8 * sizeMulW,
        strokeWidth: 5 * sizeMulW,
        padding: EdgeInsets.all(0),
        child: Container(
          // color: Colors.red,
          width: 333 * sizeMulW,
          height: 72 * sizeMulW,
          child: OutlineButton(
              // elevation: 0,
              color: Colors.white.withAlpha(0),
              onPressed: () {},
              
              borderSide: BorderSide(color: Colors.white.withAlpha(0),),
              // highlightColor: Colors.white.withAlpha(0),
              // splashColor: Colors.white.withAlpha(0),
              child: Text(
                "ADD RECEIPT",
                textAlign: TextAlign.center,
                textScaleFactor: 1.2,
                style: TextStyle(fontSize: sizeMulW * 15, 
                            color: Colors.grey[600]),
              )),
        ));
  }
}

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
                          textScaleFactor: 1,
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
