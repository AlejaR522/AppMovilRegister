import 'package:flutter/material.dart';
import '../screens/register_screen.dart';
import '../screens/forgot_password_screen.dart';
import '../screens/new_password_screen.dart';

class AppRoutes {
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String newPassword = '/new-password';

  static Map<String, WidgetBuilder> get routes => {
        register: (_) => const RegisterScreen(),
        forgotPassword: (_) => const ForgotPasswordScreen(),
        newPassword: (_) => const NewPasswordScreen(),
      };
}