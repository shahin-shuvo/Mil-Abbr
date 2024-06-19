import 'package:flutter/material.dart';

class CustomAppBar extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    var height = size.height;
    var width = size.width;
    // path.lineTo(0, size.height) ;
    // path.quadraticBezierTo(size.width/4, size.height-40, size.width/2, size.height-20) ;
    //
    // path.quadraticBezierTo(3/4 * size.width, size.height, size.width, size.height - 20) ;
    //
    // path.lineTo(size.width, 0) ;
    path.lineTo(0, height-50);
    path.quadraticBezierTo(width/2, height, width, height-50);
    path.lineTo(width, 0);


    return path ;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }



}