import 'package:flutter/material.dart';

class CustomShapeReversed extends CustomClipper<Path> {
  double maxWidth;
  double maxHeight;
  double sizeMulW;

  // maxWidth: MediaQuery.of(context).size.width,
  // maxHeight: MediaQuery.of(context).size.width * 0.91),
  CustomShapeReversed(
      {@required this.maxWidth,
      @required this.maxHeight,
      @required this.sizeMulW});

  @override
  getClip(Size size) {
    final Path path = Path();

    Offset p0 = Offset(0.43*maxWidth, maxHeight+13.735782059999957*sizeMulW); 
    Offset p1 = Offset(maxWidth*0.7, maxHeight-sizeMulW*65.77751179999998); 
    Offset p2 = Offset(maxWidth*0.14, maxHeight-sizeMulW*108.56846); 
    Offset p3 = Offset(0, maxHeight-sizeMulW*56.1561);


    // path.quadraticBezierTo( p3.dx, p3.dy, p2.dx, p2.dy); 
    // path.quadraticBezierTo( p1.dx, p1.dy,p0.dx, p0.dy,); 
    
    
    path.lineTo(0, 0);
    path.quadraticBezierTo(p3.dx, p3.dy, p2.dx, p2.dy);




    // path.lineTo(0, maxHeight-( 29.94991999999998*sizeMulW));  
    // path.quadraticBezierTo(p0.dx, p0.dy, p1.dx, p1.dy);  
    // path.quadraticBezierTo(p2.dx, p2.dy, p3.dx, p3.dy);
    // path.lineTo(size.width, 0);

    // path.lineTo(0, maxHeight-( 29.94991999999998*sizeMulW));  
    // path.quadraticBezierTo(p0.dx, p0.dy, p1.dx, p1.dy);  
    // path.quadraticBezierTo(p2.dx, p2.dy, p3.dx, p3.dy);
    // path.lineTo(size.width, 0);
    
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}

// path.lineTo(0, 0);
//     path.lineTo(0, maxHeight*0.92);
//     Offset p0 = Offset(0.43*maxWidth, maxHeight*1.03669);
//     Offset p1 = Offset(maxWidth*0.7, maxHeight*0.8243);
//     path.quadraticBezierTo(p0.dx, p0.dy, p1.dx, p1.dy);

//     Offset p2 = Offset(maxWidth*0.86, maxHeight*0.71);
//     Offset p3 = Offset(maxWidth, maxHeight*0.85);

//     path.quadraticBezierTo(p2.dx, p2.dy, p3.dx, p3.dy);
//     path.lineTo(size.width, 0);
//     path.close();
