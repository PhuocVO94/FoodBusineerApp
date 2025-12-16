import 'package:flutter/material.dart';
import 'package:food_delivery_app/home/address.dart';
import 'package:food_delivery_app/home/changepassword.dart';
import 'package:food_delivery_app/home/order_tracking_page.dart';
import 'package:food_delivery_app/pages/auth/sign_in.dart';
import 'dart:io';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String userName = "NguyễnKhuê";
  String userEmail = "nguyenanhkhue@gmail.com";

  XFile? avatarImage;
  final ImagePicker picker = ImagePicker();
  bool isPicking = false;

  @override
  Widget build(BuildContext context) {
    ImageProvider? avatarProvider;
    if (avatarImage != null) {
      avatarProvider = kIsWeb
          ? NetworkImage(avatarImage!.path)
          : FileImage(File(avatarImage!.path));
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: pickAvatar,
                      child: CircleAvatar(
                        radius: 60, // avatar to
                        backgroundColor: AppColors.mainColor,
                        backgroundImage: avatarProvider,
                        child: avatarProvider == null
                            ? Icon(Icons.person,
                                size: 70, color: Colors.white)
                            : null,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      userName,
                      style: TextStyle(
                        fontSize: Dimensions.font20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      userEmail,
                      style: TextStyle(
                        fontSize: Dimensions.font16,
                        color: Colors.white70,
                      ),
                    ),
                    
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Các menu bên dưới
              buildMenuItem(Icons.receipt_long, "Đơn hàng của tôi", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OrderTrackingPage()),
                  );
                }),
              buildMenuItem(Icons.location_on, "Địa chỉ giao hàng", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Address()),
                  );
                }),
              buildMenuItem(Icons.lock, "Đổi mật khẩu", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChangePassword()),
                  );
                }),
              buildMenuItem(Icons.logout, "Đăng xuất", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignIn()),
                  );
                }),
              const Divider(thickness: 1),
              buildMenuItem(Icons.help_outline, "Trung tâm hỗ trợ", () {}),
              buildMenuItem(Icons.privacy_tip_outlined, "Điều khoản & bảo mật", () {}),
              buildMenuItem(Icons.settings, "Cài đặt ứng dụng", () {}),
            ],
          ),
        ),
      ),
    );
  }

  void pickAvatar() async {
    if (isPicking) return;
    isPicking = true;
    try {
      final XFile? img = await picker.pickImage(source: ImageSource.gallery);
      if (img != null) {
        setState(() {
          avatarImage = img;
        });
      }
    } catch (e) {
      print("Lỗi chọn ảnh: $e");
    } finally {
      isPicking = false;
    }
  }

  Widget buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.mainColor),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
