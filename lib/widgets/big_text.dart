import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/dimensions.dart';

class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  BigText({super.key, this.color = const Color(0xffffcab88), required this.text,

    this.size = 20,
    this.overflow = TextOverflow.ellipsis});


  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w400,
        fontSize:size==0? Dimensions.font20:size,
        fontFamily: 'Roboto',

      ),



    );
  }
}
