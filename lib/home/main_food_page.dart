
/****
    import 'package:flutter/material.dart'
Day la thu vien chinh chay cho android va ios moi nguoi la chu y su dung thu vien cho chinh xacs
anh co thay doi 1 so thu vien moi nguoi nho doc ky thu vien truoc khi dung
**/
import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
class MainFoodPage  extends StatefulWidget {
  const MainFoodPage({Key? key}): super(key: key);

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
            margin: EdgeInsets.only(top: 45, bottom: 15),
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween ,
              children: [
                Column(
                  children: [
                    BigText(text: 'VietNam',color:AppColors.mainBlackColor , size: 20,),
                    Row(
                      children: [
                        SmallText(text: 'VIquoc Quan', color: AppColors.textColor, size: 14,),
                        Icon(Icons.arrow_drop_up,color: AppColors.textColor,size: 14,)
                      ],

                    ),



                  ],


                ),
                Container(
                  width: 45,
                  height: 45,
                  child: Icon(Icons.search, color: Colors.white,),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(15)
                  ),

                )

              ],

            ),
          ),



          /**Slug **/
          Container(),

        ],



      ),

    );
  }
}

