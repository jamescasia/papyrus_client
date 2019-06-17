import 'package:flutter/material.dart';
import 'package:papyrus_client/screens/HomeScreen.dart';
import 'package:papyrus_client/data_models/Message.dart';

class MessageBox extends StatelessWidget {
  Message msg;
  MessageBox(this.msg);
  @override
  Widget build(BuildContext context) {
    return Row(
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
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
          margin: EdgeInsets.all(sizeMulW * 4),
          padding: EdgeInsets.symmetric(
              horizontal: sizeMulW * 15, vertical: sizeMulW * 10),
          decoration: BoxDecoration(
              color: (msg.iAmTheSender) ? Colors.blue : Color(0xFF1ADB5B),
              borderRadius: BorderRadius.all(Radius.circular(sizeMulH * 20))),
          child: Column(
            children: <Widget>[
              Text(
                msg.message,
                style: TextStyle(
                    fontSize: sizeMulW * 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              (!msg.iAmTheSender && msg.imagePath!="")
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
    );
  }
}
