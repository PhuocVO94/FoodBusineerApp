
import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/icon_and_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';



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
          // print("current value is"+_currPagevalue.toString());
      });

    });

  }
  @override
  void dispose() {
      pageController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 330,
        // color:Colors.lightGreenAccent,
        child: PageView.builder(itemCount: 5, itemBuilder: (context, position){
          return _BuildPageView(position);
        }),

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
      height: 210,
      // padding: EdgeInsets.only(left: 15, right: 15),
      margin: EdgeInsets.only(left: 5, right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/image/Menu.png"),
        ),
    
      ),
    
      ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 115,
    
            margin: EdgeInsets.only(left: 45, right: 45, bottom: 15),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(30)
            ),
            child: Container(
              padding: EdgeInsets.only(left: 15,top: 10, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(text: 'VietNamese Food', color: const Color.fromARGB(255, 0, 0, 0),),
                  SizedBox(height: 10,),
                  Row(
    
                    children: [
                      Wrap(
                        children: [
                          // Dùng Spread Operator (...) để trích xuất các Icons từ List.generate
                          ...List.generate(
                            5,
                                (index) => Icon(
                              Icons.star,
                              color: AppColors.mainColor, // Hoặc AppColors.yellowColor
                              size: 14,
                            ),
    
                          ),
                          SizedBox(width: 10,),
                          SmallText(text: '5'),
                          SizedBox(width: 10,),
                          SmallText(text: '1278'),
                          SizedBox(width: 10,),
                          SmallText(text: 'Reviewer',)
    
                        ],
                      ),
                    ],
                  ),
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
