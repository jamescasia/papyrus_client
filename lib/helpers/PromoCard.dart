import 'package:flutter/material.dart';
import 'package:papyrus_client/screens/HomeScreen.dart';

class PromoCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String date;
  final bool unique;
  final double margin;
  final bool enabled;

  PromoCard(this.imagePath, this.title, this.date, this.unique, this.margin,
      this.enabled);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: sizeMulW * 0, vertical: sizeMulW * margin),
      width: 333 * sizeMulW,
      height: 72 * sizeMulW,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 1 * sizeMulW),
          color: (enabled) ? Colors.white : Colors.grey[350],
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

        splashColor: Colors.red,
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
                  title,
                  style: TextStyle(
                      fontSize: 16 * sizeMulW, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Valid until: " + date,
                  style: TextStyle(
                      fontSize: 13 * sizeMulW, fontWeight: FontWeight.w500),
                )
              ],
            ),
            Text(
              (unique) ? "[UNIQUE]" : "",
              style: TextStyle(
                  // color: Colors.red,
                  fontWeight: FontWeight.w500,
                  fontSize: 12 * sizeMulW),
            ),
          ],
        ),
      ),
    );
  }
}
