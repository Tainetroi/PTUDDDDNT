import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio();

  final String baseUrl = 'https://69dde8ae410caa3d47ba3047.mockapi.io/';

  Future<void> send(String endpoint, Map<String, dynamic> data) async {
    try {
      final Response = await dio.post('$baseUrl/$endpoint', data: data);
      print(Response.data);
    } catch (e) {
      print('Dio error: $e');
    }
  }
}
