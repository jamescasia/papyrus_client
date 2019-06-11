import 'package:flutter/material.dart';
import 'package:papyrus_client/screens/HomeScreen.dart';
import 'package:papyrus_client/screens/ShowReceiptScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:papyrus_client/data_models/Receipt.dart';

class ReceiptCard extends StatelessWidget {
 final Receipt receipt;
  final double margin = 6;
  final int index;

  ReceiptCard(this.receipt, this.index);
  @override
  Widget build(BuildContext context) {

    // print("" + receipt.merchant );
    // print(receipt.dateTime);
    // print(receipt.category);
    // print(receipt.items[0].name);

    return Container(
      
      margin: EdgeInsets.only(top: sizeMul * ((index!=0)?margin:130), bottom:sizeMul*margin),
      width: 333 * sizeMul,
      height: 72 * sizeMul,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 1 * sizeMul),
          color: Colors.white,
          boxShadow: [
            new BoxShadow(
              blurRadius: 2 * sizeMul,
              color: Colors.black12,
              offset: new Offset(0, 0.4 * sizeMul),
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(9 * sizeMul))),
      child: InkWell(
        onTap: () {
          print("");
        },
        borderRadius: BorderRadius.all(Radius.circular(9 * sizeMul)),
        // highlightColor: Colors.red,
        // splashColor: Colors.red,

        splashColor: Colors.amber,
        highlightColor: Colors.black.withOpacity(0.1),
        child: Material(
          color: Colors.white.withAlpha(0),
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(9 * sizeMul)),
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => ShowReceiptScreen(receipt)));
            },
            splashColor: Colors.amber,
            highlightColor: Colors.black.withOpacity(0.1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.image,
                        size: MediaQuery.of(context).size.width * 0.1),
                    Text(
                      receipt.merchant,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          fontSize: 11 * sizeMul, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      receipt.items[0].name,
                      style: TextStyle(
                          fontSize: 16 * sizeMul, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      DateTime.parse(receipt.dateTime).month.toString().substring(1,4) +" " + DateTime.parse(receipt.dateTime).day.toString() +", "+  DateTime.parse(receipt.dateTime).year.toString(),
                      style: TextStyle(fontSize: 11 * sizeMul),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "${addCommas((receipt.total.floor()))}.",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 17 * sizeMul),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: sizeMul*1.5),
                      child: Text(
                        (receipt.total.toString().split(".")[1] != "0")
                            ? "${receipt.total.toString().split(".")[1]}"
                            : "00",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 11 * sizeMul),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
