import 'dart:convert';
import 'package:flutter/material.dart';
import 'dashboard.dart'; // Đảm bảo đường dẫn đúng (thường là không có dấu / ở đầu)
import 'registration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'applogo.dart';
import 'package:http/http.dart' as http;
import 'config.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key}); // Thêm constructor tiêu chuẩn

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isNotValidate = false;
  SharedPreferences? prefs; // Đổi thành nullable để an toàn hơn

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void loginUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      setState(() {
        _isNotValidate = false; // Reset lỗi nếu người dùng đã nhập
      });

      var reqBody = {
        "email": emailController.text,
        "password": passwordController.text,
      };

      try {
        var response = await http.post(
          Uri.parse(login),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqBody),
        );

        var jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status']) {
          var myToken = jsonResponse['token'];

          // Lưu token vào máy (đảm bảo prefs đã khởi tạo xong)
          prefs ??= await SharedPreferences.getInstance();
          await prefs!.setString('token', myToken);

          if (!mounted) return;
          // Chuyển sang Dashboard và xóa sạch các màn hình trước đó
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Dashboard(token: myToken)),
            (route) => false,
          );
        } else {
          // Hiển thị thông báo nếu sai mật khẩu/email
          VxToast.show(context, msg: "Sai thông tin đăng nhập!");
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
        // Sử dụng ResizeToAvoidBottomInset để tránh lỗi tràn layout khi hiện bàn phím
        resizeToAvoidBottomInset: true,
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
                  "Email Sign-In".text.size(22).yellow100.make(),
                  20.heightBox,

                  TextField(
                    controller: emailController,
                    keyboardType:
                        TextInputType.emailAddress, // Tối ưu bàn phím cho email
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Email",
                      errorText: _isNotValidate ? "Vui lòng nhập đầy đủ" : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ).p4().px24(),

                  TextField(
                    controller: passwordController,
                    obscureText: true, // Ẩn mật khẩu
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Password",
                      errorText: _isNotValidate ? "Vui lòng nhập đầy đủ" : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ).p4().px24(),

                  20.heightBox,

                  // Nút bấm đăng nhập nhìn chuyên nghiệp hơn
                  ElevatedButton(
                    onPressed: loginUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15,
                      ),
                    ),
                    child: "Login".text.white.bold.xl.make(),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Registration()),
          ),
          child: Container(
            height: 50,
            color: Colors.white.withOpacity(0.1),
            child: Center(
              child: "Don't have an account? Sign Up".text.white.semiBold
                  .make(),
            ),
          ),
        ),
      ),
    );
  }
}
