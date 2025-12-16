import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/product_model.dart';
import 'package:food_delivery_app/utils/colors.dart';

// import '../home/main_food_page.dart';
// import '../widgets/big_text.daimport '../widgets/icon_and_text.dart';

import '../models/FoodModel.dart';
import '../widgets/big_text.dart';
import '../widgets/icon_and_text.dart';
import '../widgets/small_text.dart';
import 'dimensions.dart';

class AppColumn extends StatefulWidget {
  final FoodModel? food;
  final ProductsModel productsModel;

  const AppColumn({super.key,
    // required this.food,
     required this.productsModel, this.food,
    // required this.productsModel

  });

  @override
  State<AppColumn> createState() => _AppColumnState();
}

class _AppColumnState extends State<AppColumn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: widget.productsModel.name??''),
        SizedBox(height: Dimensions.height10),
        Row(
          children: [
            Wrap(children: List.generate(5, (index) => Icon(Icons.star, color: AppColors.mainColor, size: 15))),
            SizedBox(width: Dimensions.width10),
            SmallText(text: "4.5"),
            SizedBox(width: Dimensions.width10),
            SmallText(text: "Demo"),
            SizedBox(width: Dimensions.width10),
            SmallText(text: "comments"),
          ],
        ),
        SizedBox(height: Dimensions.height10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(icon: Icons.circle_sharp, text: "Normal", iconColor: AppColors.iconColor1, color: AppColors.textColor, iconSize: 27),
            IconAndTextWidget(icon: Icons.location_on, text: "1.2", iconColor: AppColors.iconColor1, color: AppColors.textColor, iconSize: 27),
            IconAndTextWidget(icon: Icons.access_time_rounded, text: "35", iconColor: AppColors.iconColor1, color: AppColors.textColor, iconSize: 27),

          ],
        ),
      ],
    );

  }
}
