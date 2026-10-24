import 'package:flutter/material.dart';

import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/verification_screen.dart';
import 'screens/new_password_screen.dart';
import 'screens/home_screen.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      // La app arranca en Login
      initialRoute: "/",
      // Mapa de rutas: "nombre": (contexto) => Pantalla
      routes: {
        "/": (_) => const LoginScreen(),
        "/register": (_) => const RegisterScreen(),
        "/forgot-password": (_) => const ForgotPasswordScreen(),
        "/verification": (_) => const VerificationCodeScreen(),
        "/new-password": (_) => const NewPasswordScreen(),
        "/home": (_) => const HomeScreen(),
      },
    );
  }
}
