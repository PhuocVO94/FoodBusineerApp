import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/small_text.dart';

class ExpandableTextWidget extends StatefulWidget {
   final String text;
  const ExpandableTextWidget({super.key, required this.text});

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;
  double textHeight = Dimensions.screenHeight /5.63;

  @override
  void initState() {
    super.initState();
    if(widget.text.length > textHeight){
      firstHalf = widget.text.substring(0,textHeight.toInt());
      secondHalf = widget.text.substring(textHeight.toInt()+1, widget.text.length);
    } else {
      firstHalf  = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(
        text: firstHalf,
        // Nếu không có phần secondHalf, text ngắn, không cần giới hạn dòng
        maxLines: null,
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start, // ✅ Đảm bảo column căn lề trái
        children: [
          SmallText(
            height: 1.8, // Khoảng cách dòng rộng hơn cho dễ đọc
            size: Dimensions.font16,
            color: AppColors.paraColor,
            text: hiddenText ? ("$firstHalf...") : (firstHalf + secondHalf),
            maxLines: hiddenText
                ? 5
                : null, // 👈 CẬP NHẬT: Giới hạn 5 dòng khi ẩn, xuống dòng thoải mái khi hiện (null)
            overflow: TextOverflow.fade, // Đổi sang fade hoặc ellipsis tùy ý
          ),
          // ... Phần GestureDetector (Show more/less)
          GestureDetector(
            onTap: () {
              setState(() {
                hiddenText = !hiddenText;
              });
            },
            child: Row(
              children: [
                SmallText(
                  text: hiddenText ? "Show more" : "Show less",
                  size: Dimensions.font16,
                  color: AppColors.mainColor,
                ),
                SizedBox(width: Dimensions.width10 / 2),
                Icon(
                  hiddenText ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                  color: AppColors.mainColor,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
