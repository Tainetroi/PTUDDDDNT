import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';
import 'applogo.dart';
import 'loginPage.dart';
import 'package:http/http.dart' as http;
import 'config.dart';

class Registration extends StatefulWidget {
  const Registration({super.key}); // Thêm key theo chuẩn mới

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isNotValidate = false;

  void registerUser() async {
    // Kiểm tra đầu vào cơ bản
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var regBody = {
        "email": emailController.text,
        "password": passwordController.text,
      };

      try {
        var response = await http.post(
          Uri.parse(registration),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody),
        );

        var jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == true) {
          if (!mounted) return;
          VxToast.show(context, msg: "Đăng ký thành công!");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignInPage()),
          );
        } else {
          // Xử lý khi email đã tồn tại hoặc lỗi server
          VxToast.show(context, msg: "Đăng ký thất bại. Vui lòng thử lại!");
        }
      } catch (e) {
        VxToast.show(context, msg: "Lỗi kết nối server!");
      }
    } else {
      setState(() {
        _isNotValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: context.screenWidth,
          height: context.screenHeight,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0XFFF95A3B), Color(0XFFF96713)],
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomCenter,
              stops: [0.0, 0.8],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CommonLogo(),
                  10.heightBox,
                  "CREATE YOUR ACCOUNT".text.size(22).yellow100.bold.make(),
                  20.heightBox,

                  // TextField cho Email
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Email",
                      errorText: _isNotValidate
                          ? "Vui lòng nhập thông tin"
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ).p4().px24(),

                  // TextField cho Password tích hợp Generator
                  TextField(
                    controller: passwordController,
                    obscureText:
                        false, // Để false để người dùng thấy mật khẩu vừa tạo
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.copy, color: Colors.grey),
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(text: passwordController.text),
                          );
                          VxToast.show(context, msg: "Đã sao chép mật khẩu!");
                        },
                      ),
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.vpn_key, color: Colors.blue),
                        onPressed: () {
                          passwordController.text = generatePassword();
                          setState(() {});
                        },
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Password",
                      errorText: _isNotValidate
                          ? "Vui lòng nhập thông tin"
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ).p4().px24(),

                  10.heightBox,

                  // Nút Register
                  ElevatedButton(
                    onPressed: registerUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15,
                      ),
                    ),
                    child: "Register".text.white.bold.xl.make(),
                  ).p16(),

                  // Chuyển hướng sang Sign In
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInPage(),
                        ),
                      );
                    },
                    child: HStack([
                      "Already Registered?".text.make(),
                      " Sign In".text.white.bold.make(),
                    ]).centered().p16(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Hàm tạo mật khẩu ngẫu nhiên tối ưu hơn
String generatePassword() {
  const String upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  const String lower = 'abcdefghijklmnopqrstuvwxyz';
  const String numbers = '1234567890';
  const String symbols = '!@#\$%^&*';
  const String seed = upper + lower + numbers + symbols;

  return List.generate(12, (index) {
    return seed[Random.secure().nextInt(seed.length)];
  }).join();
}
