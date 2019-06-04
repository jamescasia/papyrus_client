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
          horizontal: sizeMul * 0, vertical: sizeMul * margin),
      width: 333 * sizeMul,
      height: 72 * sizeMul,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 1 * sizeMul),
          color: (enabled) ? Colors.white : Colors.grey[350],
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
                      fontSize: 16 * sizeMul, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Valid until: " + date,
                  style: TextStyle(
                      fontSize: 13 * sizeMul, fontWeight: FontWeight.w500),
                )
              ],
            ),
            Text(
              (unique) ? "[UNIQUE]" : "",
              style: TextStyle(
                  // color: Colors.red,
                  fontWeight: FontWeight.w500,
                  fontSize: 12 * sizeMul),
            ),
          ],
        ),
      ),
    );
  }
}
