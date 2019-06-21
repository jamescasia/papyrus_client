import 'package:flutter/material.dart';
import 'package:papyrus_client/screens/HomeScreen.dart';
import 'package:intl/intl.dart';
import 'package:papyrus_client/data_models/Message.dart';

class MessageBox extends StatelessWidget {

  Widget child= SizedBox(width: 0.001,);
  Message msg;
  MessageBox(this.msg , {this.child  });
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: (msg.iAmTheSender)
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            (msg.iAmTheSender)
                ? Expanded(
                    child: Container(),
                  )
                : SizedBox(
                    width: 0,
                  ),
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7),
              margin: EdgeInsets.all(sizeMulW * 4),
              padding: EdgeInsets.symmetric(
                  horizontal: sizeMulW * 15, vertical: sizeMulW * 10),
              decoration: BoxDecoration(
                  color: (msg.iAmTheSender)
                      ? Color(0xFF1ADB5B)
                      : Color(0xFFF1F0F0),
                  borderRadius:
                      BorderRadius.all(Radius.circular(sizeMulH * 20))),
              child: Column(
                children: <Widget>[
                  Text(
                    msg.message,
                    style: TextStyle(
                        fontSize: sizeMulW * 17,
                        fontWeight: FontWeight.w500,
                        color: (msg.iAmTheSender)
                            ? Colors.white
                            : Colors.grey[600]),
                  ),
                  
                  (!msg.iAmTheSender && msg.imagePath != "")
                      ? Image(
                          image: NetworkImage(msg.imagePath),
                        )
                      : SizedBox(height: 0.001),
                ],
              ),
            ),
            (!msg.iAmTheSender)
                ? Expanded(
                    child: Container(),
                  )
                : SizedBox(
                    width: 0,
                  ),
          ],
        ),
        Text(
          "${(msg.iAmTheSender) ? "" : "   "} ${DateFormat('MM/dd/yyyy hh:mm').format(DateTime.parse(msg.dateTime)).toString()}  ${((msg.iAmTheSender) ? "   " : "")}",
          style: TextStyle(
              fontSize: sizeMulW * 14,
              color: Colors.grey[500],
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
