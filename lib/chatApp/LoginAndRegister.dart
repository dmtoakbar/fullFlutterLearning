import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:learn_getx_bloc_riverpod/chatApp/variable/globalVariable.dart';

class LoginAndRegister {
  static String baseUrl = dotenv.env['API_URL'] ?? "";

  static Future<Map<String, dynamic>> register({
    required String username,
    required String password,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"username": username, "password": password}),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        final decoded = jsonDecode(res.body);
        GlobalVariable.authenticationToken = decoded['token'];
        return {"status": "success", "data": decoded};
      } else {
        return {
          "status": "error",
          "message": "Failed with status: ${res.statusCode}",
          "body": res.body,
        };
      }
    } catch (e) {
      return {"status": "error", "message": e.toString()};
    }
  }

  static Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"username": username, "password": password}),
      );

      if (res.statusCode == 200) {
        final decoded = jsonDecode(res.body);
        GlobalVariable.authenticationToken = decoded['token'];
        return {"status": "success", "data": decoded};
      } else {
        return {
          "status": "error",
          "message": "Failed with status: ${res.statusCode}",
          "body": res.body,
        };
      }
    } catch (e) {
      return {"status": "error", "message": e.toString()};
    }
  }
}
