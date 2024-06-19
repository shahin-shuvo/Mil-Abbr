
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomShapeImage extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, size.height * 0.3);

    path.quadraticBezierTo(
        size.width / 2, size.height * 0.01, size.width, size.height * 0.3);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

} 