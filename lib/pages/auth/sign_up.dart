//import 'dart:ffi';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/show_custom_snackbar.dart';
import 'package:food_delivery_app/models/signup_body_model.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/app_text_field.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    void _registration() {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();

      if (email.isEmpty) {
        showCustomSnackbar("Nhập địa chỉ email", title: "Địa chỉ email");

      }else if(!GetUtils.isEmail(email)){
        showCustomSnackbar("Nhập địa chỉ emai hợp lệ", title: "Email không hợp lệ");

      }else if(password.isEmpty){
        showCustomSnackbar("Nhập mật khẩu", title: "Mật khẩu");

      }else if(password.length<6){
        showCustomSnackbar("Mật khẩu không được ít hơn sáu ký tự", title: "Mật khẩu");

      }else if(name.isEmpty){
        showCustomSnackbar("Nhập tên của bạn", title: "Tên");

      }else if(phone.isEmpty){
        showCustomSnackbar("Nhập số điện thoại", title: "Số điện thoại");

      }else{
        showCustomSnackbar("Vui lòng đăng nhập để bắt đầu", title: "Đăng ký thành công");
        SignUpBody signupBody = SignUpBody(email: email, 
            password: password, 
            name: name, 
            phone: phone);
        print(signupBody.toString());
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: Dimensions.screenHeight * 0.05),
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
            //email
            AppTextField(
              textController: emailController,
              hintText: "Tên đăng nhập",
              icon: Icons.person,
            ),
            SizedBox(height: Dimensions.height20),
            //password
            AppTextField(
              textController: passwordController,
              hintText: "Mật khẩu",
              icon: Icons.password_sharp,
            ),
            SizedBox(height: Dimensions.height20),
            //name
            AppTextField(
              textController: nameController,
              hintText: "Email",
              icon: Icons.email,
            ),
            SizedBox(height: Dimensions.height20),
            //phone
            AppTextField(
              textController: phoneController,
              hintText: "Số điện thoại",
              icon: Icons.phone,
            ),

            SizedBox(height: Dimensions.height15 + Dimensions.height15),

            GestureDetector(
              onTap: () {
                _registration();
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
                    text: "Đăng ký",
                    size: Dimensions.font16 + Dimensions.font12 / 2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: Dimensions.height45),
            RichText(
              text: TextSpan(
                text: "Bạn đã có tài khoản? ",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: Dimensions.font16,
                ),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Get.back(),
                    text: "Đăng nhập",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[500],
                      fontSize: Dimensions.font16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
