
/****
    import 'package:flutter/material.dart'
Day la thu vien chinh chay cho android va ios moi nguoi la chu y su dung thu vien cho chinh xacs
anh co thay doi 1 so thu vien moi nguoi nho doc ky thu vien truoc khi dung
**/
library;
import 'package:flutter/material.dart';
import 'package:food_delivery_app/home/foodpagebody.dart';

import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
class MainFoodPage  extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
   _MainFoodPageState createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      /*Day la noi dung CHinh cua main food no chu het tat ca nhung thong tin lien quan den main food*/
      body: Column(
        children: [

          /**Header **/
          Container(
            margin: EdgeInsets.only(top: Dimensions.top45, bottom: Dimensions.top15),
            padding: EdgeInsets.only(left: Dimensions.top20, right: Dimensions.top20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween ,
              children: [
                Column(
                  children: [
                    BigText(text: 'VietNam',color:AppColors.mainBlackColor , size: Dimensions.font20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(text: 'VI', color: AppColors.textColor, size: Dimensions.font12,),
                        Icon(Icons.arrow_drop_up,color: AppColors.textColor,size: Dimensions.font12,)
                      ],

                    ),



                  ],


                ),
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 255, 8),
                    borderRadius: BorderRadius.circular(35)
                  ),
                  child: Icon(Icons.search, color: Colors.white,size: Dimensions.icon24,),

                )

              ],

            ),
          ),



          /**Slug **/
          Expanded(child: SingleChildScrollView(
            child:  Foodpagebody(),
          ))
          // Foodpagebody(),

        ],



      ),

    );
  }
}

