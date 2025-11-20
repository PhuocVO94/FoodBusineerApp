import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/dimensions.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final double height;
  final TextOverflow overflow;   // ✅ THÊM THUỘC TÍNH OVERFLOW

  const SmallText({
    Key? key,
    this.color = const Color(0xFFccc7c5),
    required this.text,
    this.size = 12,
    this.height = 1.2,
    this.overflow = TextOverflow.ellipsis,   // ✅ THÊM DEFAULT VALUE
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,               // ✅ THÊM maxLines
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
