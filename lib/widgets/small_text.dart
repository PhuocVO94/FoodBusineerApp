import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/dimensions.dart';

class SmallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  SmallText({super.key, this.color = const Color(0xFFffcab88), required this.text,

    this.size = 14,
    this.overflow = TextOverflow.ellipsis});


  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w600,
        fontSize: size  ==0?Dimensions.font12:size,
        fontFamily: 'Roboto',

      ),



    );
  }
}
