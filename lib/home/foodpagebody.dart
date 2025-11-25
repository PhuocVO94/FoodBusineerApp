import 'package:flutter/material.dart';
// CÁC DÒNG IMPORT QUAN TRỌNG - ĐÃ CHỈNH KHỚP VỚI ẢNH CỦA BẠN
import '../utils/colors.dart';
import '../widgets/big_text.dart';
import '../widgets/icon_and_text.dart'; 
import '../widgets/small_text.dart';
import '../models/FoodModel.dart'; // Import file model.dart bạn vừa sửa
import 'food_detail_page.dart'; // Import trang chi tiết bạn vừa tạo cùng thư mục

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;

  const IconAndTextWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 1. Icon
        Icon(icon, color: iconColor, size: 24),
        // 2. Khoảng cách
        const SizedBox(width: 5),
        // 3. Chữ (Text)
        SmallText(text: text, color: AppColors.paraColor),
      ],
    );
  }
}

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = 220;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  return SingleChildScrollView( 
    child: Column(
      children: [
        // --- SLIDER (PAGEVIEW) ---
        Container(
          height: 320,
          child: PageView.builder(
            controller: pageController,
            itemCount: vietnameseFoods.length > 5 ? 5 : vietnameseFoods.length,
            itemBuilder: (context, position) {
              return _buildPageItem(position, vietnameseFoods[position]);
            },
          ),
        ),
        
        // --- DOTS INDICATOR ---
        new DotsIndicator(pageValue: _currPageValue),

        // --- TIÊU ĐỀ DANH SÁCH ---
        SizedBox(height: 30),
        Container(
          margin: EdgeInsets.only(left: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Thực đơn Việt"),
              SizedBox(width: 10),
              Container(margin: EdgeInsets.only(bottom: 3), child: BigText(text: ".", color: Colors.black26)),
              SizedBox(width: 10),
              Container(margin: EdgeInsets.only(bottom: 2), child: SmallText(text: "Hương vị quê hương")),
            ],
          ),
        ),

        // --- DANH SÁCH MÓN ĂN (LIST VIEW) ---
        ListView.builder(
          physics: NeverScrollableScrollPhysics(), 
          shrinkWrap: true,
          itemCount: vietnameseFoods.length,
          itemBuilder: (context, index) {

            FoodModel food = vietnameseFoods[index]; // Lấy dữ liệu món ăn

            return GestureDetector(
              // SỰ KIỆN BẤM VÀO MÓN ĂN
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FoodDetailPage(food: food)));
              },
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: Row(
                  children: [
                    // Hình ảnh
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white38,
                        image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(food.image)),
                      ),
                    ),
                    // Thông tin chi tiết
                    Expanded(
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
                          color: Colors.white,
                          boxShadow: [BoxShadow(color: Color(0xFFe8e8e8), blurRadius: 5.0, offset: Offset(0, 5))],
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BigText(text: food.name), // Tên món ăn từ Model
                              SizedBox(height: 10),
                              SmallText(text: food.description, overflow: TextOverflow.ellipsis), // Mô tả ngắn gọn
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconAndTextWidget(icon: Icons.circle_sharp, text: "Normal", iconColor: AppColors.iconColor1),
                                  IconAndTextWidget(icon: Icons.location_on, text: food.location, iconColor: AppColors.mainColor),
                                  IconAndTextWidget(icon: Icons.access_time_rounded, text: food.time, iconColor: AppColors.iconColor2),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    ),
  ); 
}

  // Scalle Page ITem
  
  Widget _buildPageItem(int index, FoodModel food) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale = _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 0);
    }

    return Transform(
      transform: matrix,
      child: GestureDetector(
        onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => FoodDetailPage(food: food)));
        },
        child: Stack(
          children: [
            Container(
              height: 220,
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(food.image)),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 120,
                margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Color(0xFFe8e8e8), blurRadius: 5.0, offset: Offset(0, 5)),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                  ],
                ),
                child: Container(
                  padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(text: food.name),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Wrap(children: List.generate(5, (index) => Icon(Icons.star, color: AppColors.mainColor, size: 15))),
                          SizedBox(width: 10),
                          SmallText(text: "${food.rating}"),
                          SizedBox(width: 10),
                          SmallText(text: "${food.commentsCount}"),
                          SizedBox(width: 10),
                          SmallText(text: "comments"),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconAndTextWidget(icon: Icons.circle_sharp, text: "Normal", iconColor: AppColors.iconColor1),
                          IconAndTextWidget(icon: Icons.location_on, text: food.location, iconColor: AppColors.mainColor),
                          IconAndTextWidget(icon: Icons.access_time_rounded, text: food.time, iconColor: AppColors.iconColor2),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper widget cho Dots Indicator
class DotsIndicator extends StatelessWidget {
  final double pageValue;
  const DotsIndicator({Key? key, required this.pageValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          width: pageValue.round() == index ? 10 : 8,
          height: pageValue.round() == index ? 10 : 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: pageValue.round() == index ? AppColors.mainColor : Colors.grey,
          ),
        );
      }),
    );
  }
}