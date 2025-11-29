// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:food_delivery_app/home/order_tracking_page.dart';
import 'package:food_delivery_app/home/address.dart';
import 'package:food_delivery_app/home/changepassword.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isLoggedIn = false;

  String userName = "Nguyễn Văn A";
  String userEmail = "nguyenvana@gmail.com";

  XFile? avatarImage;
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {

    ImageProvider? avatarProvider;
    if (avatarImage != null) {
      avatarProvider = kIsWeb
          ? NetworkImage(avatarImage!.path)
          : FileImage(File(avatarImage!.path));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trang cá nhân"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // AVATAR
            Center(
              child: InkWell(
                onTap: () {
                  if (isLoggedIn) {
                    pickAvatar();
                  } else {
                    showLoginDialog(context);
                  }
                },
                child: CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: avatarProvider,
                  child: avatarProvider == null
                      ? Icon(Icons.person,
                          size: 60, color: Colors.grey.shade800)
                      : null,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // PHẦN CHƯA ĐĂNG NHẬP
            if (!isLoggedIn) ...[
              const Text(
                "Chào mừng bạn !",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 137, 218, 208),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () => showLoginDialog(context),
                  child: const Text("Đăng nhập"),
                ),
              ),
              const SizedBox(height: 6),
              Center(
                child: TextButton(
                  onPressed: () => showRegisterDialog(context),
                  child: const Text("Tạo tài khoản ?",style: TextStyle(color: Colors.blueAccent,fontSize: 14,),
                  ),
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () => showForgotPasswordDialog(context),
                  child: const Text("Quên mật khẩu",style: TextStyle(color: Colors.blueAccent,fontSize: 14,),
                  ),
                ),
              ),
            ],

            // PHẦN ĐÃ ĐĂNG NHẬP
            if (isLoggedIn) ...[
              Text(
                userName,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                userEmail,
                style: const TextStyle(color: Colors.black45),
              ),
              const SizedBox(height: 20),
              buildMenuItem(Icons.receipt_long, "Đơn hàng của tôi", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OrderTrackingPage()),
                );
              }),
              buildMenuItem(Icons.location_on, "Địa chỉ giao hàng", (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Address()),
                );
              }),
              buildMenuItem(Icons.lock, "Đổi mật khẩu", (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChangePassword()),
                );
              }),
              buildMenuItem(Icons.info_outline, "Thông tin tài khoản", (){}),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 137, 218, 208)),
                onPressed: () {
                  setState(() {
                    isLoggedIn = false;
                  });
                },
                child: const Text("Đăng xuất"),
              ),
            ],

            const SizedBox(height: 25),
            const Divider(thickness: 1),
            buildMenuItem(Icons.help_outline, "Trung tâm hỗ trợ", (){}),
            buildMenuItem(Icons.privacy_tip_outlined, "Điều khoản & bảo mật", (){}),
            buildMenuItem(Icons.settings, "Cài đặt ứng dụng", (){}),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
bool isPicking = false;

// AVATAR
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

// LOGIN
  void showLoginDialog(BuildContext context) {
    final emailController = TextEditingController();
    final passController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Đăng nhập"),
          content: SizedBox(
            height: 160,
            child: Column(
              children: [
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                TextField(
                  controller: passController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Mật khẩu"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Hủy"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isLoggedIn = true;
                  userEmail = emailController.text;
                  userName = "Người dùng";
                });
                Navigator.pop(context);
              },
              child: const Text("Đăng nhập"),
            )
          ],
        );
      },
    );
  }

// REGISTER
  void showRegisterDialog(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Đăng ký"),
          content: SizedBox(
            height: 200,
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Họ và tên"),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                TextField(
                  controller: passController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Mật khẩu"),
                ),
                TextField(
                  controller: passController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Xác nhận mật khẩu"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Hủy"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isLoggedIn = true;
                  userName = nameController.text;
                  userEmail = emailController.text;
                });
                Navigator.pop(context);
              },
              child: const Text("Tạo tài khoản"),
            )
          ],
        );
      },
    );
  }

  // FORGOT PW
  void showForgotPasswordDialog(BuildContext context) {
  final emailController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Khôi phục mật khẩu"),
        content: SizedBox(
          height: 100,
          child: Column(
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Nhập email của bạn"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text("Hủy"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: const Text("Gửi yêu cầu"),
            onPressed: () {
              // TODO: Gửi email khôi phục mật khẩu
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Đã gửi yêu cầu đến ${emailController.text}")),
              );
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}


  Widget buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
