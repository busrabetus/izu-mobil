import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import '../services/token_service.dart';
import '../screens/login_page.dart';

Future<void> checkTokenAndRedirect(BuildContext context) async {
  final token = await AuthService.getToken();

  if (token == null || Jwt.isExpired(token)) {
    await AuthService.removeToken();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
          (route) => false,
    );
  }
}

