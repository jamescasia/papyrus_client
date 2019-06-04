import 'package:flutter/material.dart';
import 'package:papyrus_client/screens/HomeScreen.dart';
import 'package:papyrus_client/screens/ShowReceiptScreen.dart';
import 'package:flutter/cupertino.dart';

class ReceiptCard extends StatelessWidget {
  final String date;
  final double total;
  final String mainItem;
  final String imagePath;
  final double margin;

  ReceiptCard(
      this.date, this.total, this.mainItem, this.imagePath, this.margin);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: sizeMul * 0, vertical: sizeMul * margin),
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
                      builder: (context) => ShowReceiptScreen()));
            },
            splashColor: Colors.amber,
            highlightColor: Colors.black.withOpacity(0.1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset(
                  imagePath,
                  height: MediaQuery.of(context).size.width * 0.12,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      mainItem,
                      style: TextStyle(
                          fontSize: 16 * sizeMul, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      date,
                      style: TextStyle(fontSize: 11 * sizeMul),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "${addCommas((total.floor()))}.",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 17 * sizeMul),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: sizeMul),
                      child: Text(
                        (total.toString().split(".")[1] != "0")
                            ? "${total.toString().split(".")[1]}"
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
