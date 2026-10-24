import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../utils/validators.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';
import '../widgets/decor_shape.dart';
import '../widgets/gradient_icon_box.dart';

import 'dart:math';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  // El formulario es válido si el correo tiene buen formato
  // Y la contraseña no está vacía. Con esto se habilita el botón.
  bool get _formValid =>
      Validators.email(_emailCtrl.text) == null && _passCtrl.text.isNotEmpty;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  // Va a Home enviando el correo. pushReplacement reemplaza el Login
  // para que no se pueda volver con la flecha atrás.
  void _login() {
    Navigator.pushReplacementNamed(
      context,
      '/home',
      arguments: _emailCtrl.text.trim(),
    );
  }

  // Mensaje para los botones de Google y Apple
  void _unavailable() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Funcionalidad no disponible')),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Tamaño de la pantalla, para que las formas se adapten
    final size = MediaQuery.of(context).size;
    // Tamaño del círculo grande: 75% del ancho, pero nunca más de 320
    final circulo = min(size.width * 0.75, 320.0);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // ---------- Formas decorativas ----------
          Positioned(
            top: -90,
            right: -80,
            child: DecorShape(
              size: circulo,
              gradient: AppColors.buttonGradient,
            ),
          ),
          Positioned(
            top: 80,
            left: 36,
            child: DecorShape(size: 26, color: AppColors.yellow),
          ),
          Positioned(
            top: 150,
            left: -60,
            child: DecorShape(size: 130, gradient: AppColors.blueGradient),
          ),
          Positioned(
            top: size.height * 0.68,
            left: -18,
            child: DecorShape(
              size: 34,
              type: ShapeType.ring,
              color: const Color(0xFF06B6D4),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -30,
            child: DecorShape(size: 150, gradient: AppColors.pinkGradient),
          ),
          Positioned(
            bottom: 20,
            right: -8,
            child: DecorShape(
              size: 62,
              type: ShapeType.square,
              gradient: AppColors.orangeGradient,
              rotation: 0.35,
            ),
          ),

          // ---------- Contenido ----------
          SafeArea(
            child: Center(
              // Limita el ancho en pantallas grandes (como Chrome)
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 56),
                      const GradientIconBox(
                        icon: Icons.lock_outline_rounded,
                        size: 68,
                        radius: 20,
                      ),
                      const SizedBox(height: 22),
                      const Text(
                        'Bienvenido de nuevo',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Inicia sesión para continuar',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 78, 80, 84),
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Correo: el error aparece mientras se escribe
                      // (gracias al autovalidateMode de CustomInput)
                      CustomInput(
                        label: 'Correo electrónico',
                        hint: 'tu@correo.com',
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.email,
                        // setState recalcula si el botón se habilita
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 16),
                      CustomInput(
                        label: 'Contraseña',
                        hint: '••••••••',
                        controller: _passCtrl,
                        isPassword: true,
                        onChanged: (_) => setState(() {}),
                      ),

                      // Enlace a Recuperar contraseña
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/forgot-password'),
                          child: const Text(
                            '¿Olvidaste tu contraseña?',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Deshabilitado hasta que el formulario sea válido
                      CustomButton(
                        text: 'Iniciar sesión',
                        onPressed: _formValid ? _login : null,
                      ),
                      const SizedBox(height: 24),

                      // Divisor "o continúa con"
                      const Row(
                        children: [
                          Expanded(
                            child: Divider(color: AppColors.inputBorder),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              'o continúa con',
                              style: TextStyle(
                                color: AppColors.textGrey,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(color: AppColors.inputBorder),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Botones secundarios lado a lado
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              text: 'Google',
                              isPrimary: false,
                              onPressed: _unavailable,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: CustomButton(
                              text: 'Apple',
                              isPrimary: false,
                              onPressed: _unavailable,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 48),

                      // Pie: ir a Registro
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '¿No tienes cuenta? ',
                            style: TextStyle(
                              color: AppColors.textGrey,
                              fontSize: 13,
                            ),
                          ),
                          GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, '/register'),
                            child: const Text(
                              'Regístrate',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
