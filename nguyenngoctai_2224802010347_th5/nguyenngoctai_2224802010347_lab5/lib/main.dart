import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loginPage.dart';

void main() async {
  // Đảm bảo các dịch vụ của Flutter được khởi tạo trước khi gọi SharedPreferences
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  final String? token; // Xác định rõ kiểu String? để tránh lỗi null safety
  const MyApp({this.token, super.key}); // Sử dụng super.key theo chuẩn mới

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Cập nhật lên ColorScheme (chuẩn Material 3)
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Logic kiểm tra Token
      home: _getHomeView(),
    );
  }

  Widget _getHomeView() {
    // 1. Kiểm tra token có tồn tại không
    // 2. Kiểm tra token có bị lỗi cấu trúc không (dùng try-catch)
    // 3. Kiểm tra token có hết hạn không
    if (token != null && token!.isNotEmpty) {
      try {
        bool isExpired = JwtDecoder.isExpired(token!);
        if (!isExpired) {
          return Dashboard(token: token!);
        }
      } catch (e) {
        // Nếu token bị lỗi định dạng (ví dụ người dùng sửa file shared_pref)
        debugPrint("Token invalid: $e");
      }
    }

    // Mặc định về trang Login nếu không thỏa mãn các điều kiện trên
    return const SignInPage();
  }
}
