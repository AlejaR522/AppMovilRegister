import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFFF8F7FF);
  static const Color textDark = Color(0xFF1A1A2E);
  static const Color textGrey = Color(0xFF6B7280);
  static const Color inputFill = Color(0xFFF9FAFB);
  static const Color inputBorder = Color(0xFFE5E7EB);
  static const Color primary = Color(0xFF7C3AED);
  static const Color pink = Color(0xFFEC4899);
  static const Color error = Color(0xFFEF4444);
  static const Color success = Color(0xFF22C55E);
  static const Color yellow = Color(0xFFFACC15);

  // Degradado del botón principal (morado -> rosado)
  static const LinearGradient buttonGradient = LinearGradient(
    colors: [primary, pink],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient orangeGradient = LinearGradient(
    colors: [Color(0xFFF43F5E), Color(0xFFF97316)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient blueGradient = LinearGradient(
    colors: [Color(0xFF0EA5E9), Color(0xFF6366F1)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient pinkGradient = LinearGradient(
    colors: [Color(0xFFA855F7), Color(0xFFEC4899)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}