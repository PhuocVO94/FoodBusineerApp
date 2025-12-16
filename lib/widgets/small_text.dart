import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/dimensions.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final double height;
  final TextOverflow overflow;  // ✅ THÊM THUỘC TÍNH OVERFLOW
  final int? maxLines;
  const SmallText({
    super.key,
    this.color = const Color(0xFFccc7c5),
    required this.text,
    this.size = 12,
    this.height = 1.2,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines,//
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,               // ✅ THÊM maxLines
      overflow: overflow,        // ✅ TRUYỀN overflow
      style: TextStyle(
        fontFamily: 'Roboto',
        color: color,
        fontSize: size,
        height: height,
      ),
    );
  }
}
