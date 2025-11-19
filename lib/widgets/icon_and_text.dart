import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/small_text.dart';


class IconAndTextWidget  extends StatefulWidget {

  final IconData icon;
  final double iconSize;
  final String text;
  final Color iconColor;
  final Color color;


  const IconAndTextWidget({key,
    required this.icon,
    required this.text,
    required this.iconColor,
    required this.color, required this.iconSize}) :super(key: key);

  @override
  State<IconAndTextWidget> createState() => _IconAndTextState();
}

class _IconAndTextState extends State<IconAndTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(widget.icon, color: widget.iconColor,size: Dimensions.font12,),
        SizedBox(width: 5,),
        SmallText(text: widget.text, color: widget.color,size: 12,)
      ],
    );
  }
}
