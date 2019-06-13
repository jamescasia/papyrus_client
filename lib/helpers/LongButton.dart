import 'package:flutter/material.dart';
import 'package:papyrus_client/screens/HomeScreen.dart';

class LongButton extends StatelessWidget {
  final Color bgColor;
  final double width;
  final double height;
  final double shadowOffset;
  final Color splashColor;
  final Color highlightColor;
  final double borderRadius;
  final Function callback;
  final Widget child;

  LongButton(
      this.bgColor,
      this.width,
      this.height,
      this.shadowOffset,
      this.splashColor,
      this.highlightColor,
      this.borderRadius,
      this.callback,
      this.child);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      // margin: EdgeInsets.only(
      //     top: sizeMul *9,
      //     bottom: sizeMul * 9),
      decoration: BoxDecoration(
        boxShadow: [
          new BoxShadow(
            blurRadius: 4,
            color: Colors.black12,
            offset: new Offset(shadowOffset, shadowOffset),
          ),
          new BoxShadow(
            blurRadius: 4,
            color: Colors.black12,
            offset: new Offset(shadowOffset, shadowOffset),
          )
        ],
        color: bgColor,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
      child: GestureDetector(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: (BorderRadius.circular(borderRadius)),
            onTap: () {
              callback();
            },
            highlightColor: highlightColor.withOpacity(0.7),
            splashColor: splashColor.withOpacity(0.7),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}
