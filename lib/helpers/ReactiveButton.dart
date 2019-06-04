import 'package:flutter/material.dart';

class ReactiveButton extends StatefulWidget {
  LinearGradient bgGradient;
  Function onTaps;
  String label;
  Color highlightColor, splashColor;
  double width, height, shadowHeight, borderRadius, fontSize;

  ReactiveButton(
      {Key key,
      @required this.onTaps,
      @required this.fontSize,
      @required this.label,
      @required this.bgGradient,
      @required this.width,
      @required this.height,
      @required this.shadowHeight,
      @required this.borderRadius,
      @required this.highlightColor,
      @required this.splashColor})
      : super(key: key);
  @override
  _ReactiveButtonState createState() => new _ReactiveButtonState(
      fontSize:this.fontSize,
      label: this.label,
      onTaps: this.onTaps,
      bgGradient: this.bgGradient,
      highlightColor: this.highlightColor,
      splashColor: this.splashColor,
      width: this.width,
      height: this.height,
      shadowHeight: this.shadowHeight,
      borderRadius: this.borderRadius);
}

class _ReactiveButtonState extends State<ReactiveButton> {
  LinearGradient bgGradient;
  int inc = 0;
  String label;
  Function onTaps;
  Color highlightColor, splashColor;
  double width, height, shadowHeight, borderRadius, btnScale = 1, fontSize;

  _ReactiveButtonState(
      {Key key,
      @required this.onTaps,
      @required this.fontSize,
      @required this.bgGradient,
      @required this.width,
      @required this.label,
      @required this.height,
      @required this.shadowHeight,
      @required this.borderRadius,
      @required this.highlightColor,
      @required this.splashColor});
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return new Transform.scale(
      scale: btnScale,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            boxShadow: [
              new BoxShadow(
                blurRadius: 4,
                color: Colors.black12,
                offset: new Offset(-shadowHeight, shadowHeight),
              ),
              new BoxShadow(
                blurRadius: 4,
                color: Colors.black12,
                offset: new Offset(shadowHeight, shadowHeight),
              )
            ],
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            gradient: bgGradient),
        child: GestureDetector(
          onTapCancel: () {
            setState(() {});
            shadowHeight = 3;
            btnScale = 1.0;
          },
          onTapDown: (loc) {
            shadowHeight = 0;
            btnScale = 0.99;
            setState(() {});
          },
          onTapUp: (loc) {
            setState(() {});
            shadowHeight = 3;
            btnScale = 1.0;
          },
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: (BorderRadius.circular(100)),
              onTap: () {
                onTaps();
              },
              highlightColor: highlightColor,
              splashColor: splashColor,
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize:fontSize,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
