import 'package:flutter/material.dart';
import 'package:papyrus_client/screens/HomeScreen.dart';
import 'package:papyrus_client/screens/ShowReceiptScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:papyrus_client/screens/ShowNewsScreen.dart';
import 'package:papyrus_client/data_models/News.dart';

Widget NewsFeedCard(BuildContext context, News news, index) {
  double margin = 9;

  return Container(
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
      splashColor: Colors.amber,
      highlightColor: Colors.black.withOpacity(0.1),
      child: Material(
        color: Colors.white.withAlpha(0),
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(9 * sizeMulW)),
          onTap: () {
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => ShowNewsScreen(news)));
          },
          splashColor: Colors.amber,
          highlightColor: Colors.black.withOpacity(0.1),
          child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: sizeMulW * 12, vertical: sizeMulW * 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    news.title,
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.grey[800]),
                    textScaleFactor: 1,
                    overflow: TextOverflow.fade,
                    maxLines: 2,
                  ),
                  // Text(news.author),
                  Text(
                    DateFormat('MM/dd/yyyy')
                        .format(DateTime.parse(news.publishedDate)),
                    textScaleFactor: 0.9,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              )),
        ),
      ),
    ),
  );
}
