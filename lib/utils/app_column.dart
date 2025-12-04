import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/colors.dart';

// import '../home/main_food_page.dart';
// import '../widgets/big_text.daimport '../widgets/icon_and_text.dart';

import '../widgets/big_text.dart';
import '../widgets/icon_and_text.dart';
import '../widgets/small_text.dart';
import 'dimensions.dart';

class AppColumn extends StatefulWidget {
  const AppColumn({super.key});

  @override
  State<AppColumn> createState() => _AppColumnState();
}

class _AppColumnState extends State<AppColumn> {
  @override
  Widget build(BuildContext context) {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    BigText(text: "Demo"), // Tên món ăn từ Model
    SizedBox(height: Dimensions.height10),
    SmallText(text: "Demo", overflow: TextOverflow.ellipsis), // Mô tả ngắn gọn
    SizedBox(height: Dimensions.height10),
    Row(

    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    IconAndTextWidget(icon: Icons.circle_sharp, text: "Ngon", iconColor: AppColors.iconColor1, color: AppColors.textColor, iconSize: 27),
    IconAndTextWidget(icon: Icons.location_on, text: "Test", iconColor: AppColors.iconColor1, color: AppColors.textColor, iconSize: 27),
    IconAndTextWidget(icon: Icons.access_time_rounded, text: "Test", iconColor: AppColors.iconColor1, color: AppColors.textColor, iconSize: 27),

      ],

    )]);

  }
}
