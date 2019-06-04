import 'package:flutter/material.dart';

class CustomShapeClipper extends CustomClipper<Path>{
  double maxWidth;
  double maxHeight;
  double sizeMul;
  
                // maxWidth: MediaQuery.of(context).size.width,
                // maxHeight: MediaQuery.of(context).size.width * 0.91),
  CustomShapeClipper({ 
    @required this.maxWidth, 
    @required this.maxHeight,
    @required this.sizeMul
  });



  @override 
  getClip(Size size) { 
    final Path path = Path();  
    path.lineTo(0, 0);
    path.lineTo(0, maxHeight-( 29.94991999999998*sizeMul)); 
    Offset p0 = Offset(0.43*maxWidth, maxHeight+13.735782059999957*sizeMul); 
    Offset p1 = Offset(maxWidth*0.7, maxHeight-sizeMul*65.77751179999998); 
    path.quadraticBezierTo(p0.dx, p0.dy, p1.dx, p1.dy); 

    Offset p2 = Offset(maxWidth*0.86, maxHeight-sizeMul*108.56846); 
    Offset p3 = Offset(maxWidth, maxHeight-sizeMul*56.1561);
    
    path.quadraticBezierTo(p2.dx, p2.dy, p3.dx, p3.dy); 
    path.lineTo(size.width, 0);
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