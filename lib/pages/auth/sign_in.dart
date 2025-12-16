import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/home/food_detail_page.dart';
import 'package:food_delivery_app/pages/auth/sign_up.dart';
import 'package:food_delivery_app/base/show_custom_snackbar.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/app_text_field.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var nameController = TextEditingController();
    var passwordController = TextEditingController();
       var signUpImages = [
      "f.png",
      "g.png"
    ];

    void _login() {
      String name = nameController.text.trim();
      String password = passwordController.text.trim();
      

      if (name.isEmpty) {
        showCustomSnackbar("Vui lòng nhập thông tin", title: "Tên đăng nhập", isError: true);

      }else if(password.isEmpty){
        showCustomSnackbar("Vui lòng nhập mật khẩu", title: "Mật khẩu", isError: true);

      }else if(password.length<6){
        showCustomSnackbar("Mật khẩu không được ít hơn sáu ký tự", title: "Mật khẩu", isError: true);

      }else{
        showCustomSnackbar("", title: "Đăng nhập thành công", isError: false);
        Get.off(() => MainFoodPage());
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: Dimensions.screenHeight * 0.06),
            //logo
            Container(
              height: Dimensions.screenHeight * 0.25,
              child: Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage("assets/image/logo.png"),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: Dimensions.width20,),
              child: Column(
                children: [
                  Text(
                    "Hello",
                    style: TextStyle(
                      fontSize: Dimensions.font20*3+Dimensions.font20/2,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            ),
            //name
            AppTextField(
              textController: nameController,
              hintText: "Tên đăng nhập",
              icon: Icons.person,
            ),
            SizedBox(height: Dimensions.height20),
            //password
            AppTextField(
              textController: passwordController,
              hintText: "Mật khẩu",
              icon: Icons.password_sharp,
              isPassword: true,
            ),
            SizedBox(height: Dimensions.height20),

            Row(
              children: [
              ],
            ),
            SizedBox(height: Dimensions.height15),
            //sign in
             GestureDetector(
              onTap: (){
                _login();
              },
               child: Container(
                width: Dimensions.screenWidth / 1.8,
                height: Dimensions.screenHeight / 16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: AppColors.mainColor,
                ),
                child: Center(
                  child: BigText(
                    text: "Đăng nhập",
                    size: Dimensions.font16 + Dimensions.font12 / 2,
                    color: Colors.white,
                  ),
                ),
                           ),
             ),
            SizedBox(height: Dimensions.screenHeight*0.03,),
            RichText(
              text: TextSpan(
                text: "Bạn không có tài khoản? ",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: Dimensions.font16,
                ),
              children: [
                TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUp()),
                  text: "Đăng ký",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[500],
                    fontSize: Dimensions.font16
                  )
                ),
              ]
              ),
            ),
            SizedBox(height: Dimensions.screenHeight*0.15,),
            RichText(
              text: TextSpan(
                text: "Đăng nhập với phương thức khác ",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: Dimensions.font16,
                ),
              ),
            ),
            Wrap(
              children: List.generate(2, (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: Dimensions.radius20,
                  backgroundImage: AssetImage(
                    "assets/image/"+signUpImages[index]
                  ),
                ),
              ))
            ),
          ],
        ),
      ),
    );
  }
}
