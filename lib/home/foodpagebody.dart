
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/icon_and_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';




class Foodpagebody extends StatefulWidget {

  const Foodpagebody({super.key});

  @override
  State<Foodpagebody> createState() => _FoodpagebodyState();
}

class _FoodpagebodyState extends State<Foodpagebody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPagevalue = 0.0;
  double _scaleFacetory = 0.8;
  double _height = 220;
  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
      setState(() {

        _currPagevalue = pageController.page!;
          // print("current value is"+ MediaQuery.of(context).size.toString());
      });

    });

  }
  @override
  void dispose() {
      pageController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Container(
      height: 330,
      child: PageView.builder(
          controller: pageController,
          itemCount: 5, itemBuilder: (context, position){
        return _BuildPageView(position);
      }),

    ),
    new DotsIndicator(
    dotsCount: 5,
    position: _currPagevalue,
    decorator: DotsDecorator(
    activeColor: AppColors.mainColor,
    size: const Size.square(9.0),
    activeSize: const Size(18.0, 9.0),
    activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    ),
    ),

      ],

    );


  }

  Widget _BuildPageView(int index){

      Matrix4 matrix4 = Matrix4.identity();
      if(index == _currPagevalue.floor()) {

        var curSacle = 1-( _currPagevalue - index)* (1 - _scaleFacetory);
        var currTran  = _height*(1 - curSacle)/2;
        matrix4 = Matrix4.diagonal3Values(1, curSacle, 1)..setTranslationRaw(0,currTran , 0);
      }else if (index == _currPagevalue.floor() + 1){

        var curSacle = _scaleFacetory + ( _currPagevalue - index + 1) * (1 - _scaleFacetory);
        var currTran  = _height*(1 - curSacle)/2;
        matrix4 = Matrix4.diagonal3Values(1, curSacle, 1);
        matrix4 = Matrix4.diagonal3Values(1, curSacle, 1)..setTranslationRaw(0,currTran , 0);

      }else if (index == _currPagevalue.floor() - 1){

        var curSacle = 1-( _currPagevalue - index)* (1 - _scaleFacetory);
        var currTran  = _height*(1 - curSacle)/2;
        matrix4 = Matrix4.diagonal3Values(1, curSacle, 1);
        matrix4 = Matrix4.diagonal3Values(1, curSacle, 1)..setTranslationRaw(0,currTran , 0);

      }


      return Transform(
    transform: matrix4,
    child: Stack(
      children: [
      Container(
      height: Dimensions.viewPageContainer,
      // padding: EdgeInsets.only(left: 15, right: 15),
      margin: EdgeInsets.only(left: Dimensions.top5, right: Dimensions.top5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius30),
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/image/Menu.png"),
        ),
    
      ),
    
      ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: Dimensions.viewPageTextContainer,
    
            margin: EdgeInsets.only(left: Dimensions.top30, right: Dimensions.top30, bottom: Dimensions.top20),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(Dimensions.radius30)
            ),
            child: Container(
              padding: EdgeInsets.only(left: Dimensions.top15,top: Dimensions.top10, right: Dimensions.top15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(text: 'VietNamese Food', color: const Color.fromARGB(255, 0, 0, 0)),
                  SizedBox(height: Dimensions.height10,),
                  Row(
                    children: [
                      // 1. Dãy 5 sao (Wrap không cần thiết ở đây, dùng Row hoặc Spread Operator là đủ)
                      ...List.generate(
                        5,
                            (index) => Icon(
                          Icons.star,
                          color: AppColors.mainColor,
                          size: Dimensions.font12,
                        ),
                      ),

                      // 2. Khoảng cách (Nếu bạn có thêm text/icon khác)
                      SizedBox(width: Dimensions.width10),

                      SizedBox(width: Dimensions.width5),
                      SmallText(text: '4.5'), // Thường có điểm số bên cạnh
                      SizedBox(width: Dimensions.width10),

                      // 4. Số lượng Review (1278)
                      SmallText(text: '1278'),

                      SizedBox(width: Dimensions.width10), // Khoảng cách nhỏ giữa số lượng và từ "Reviewer"

                      // 5. Từ "Reviewer"
                      SmallText(text: 'Reviewer'),
                    ],
                  ),
                  SizedBox(height: Dimensions.height10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconAndTextWidget(icon: Icons.circle, text: 'Momar', iconColor: AppColors.yellowColor, color: AppColors.textColor),
                      IconAndTextWidget(icon: Icons.location_on, text: '1.7 km', iconColor: AppColors.yellowColor, color: AppColors.textColor),
                      IconAndTextWidget(icon: Icons.timeline_outlined, text: '32 min', iconColor: AppColors.yellowColor, color: AppColors.textColor)
                    ],
                  )
                ],
              ),
    
            )
          ),
        )
      ],
    
    ),
  );

  }

}
