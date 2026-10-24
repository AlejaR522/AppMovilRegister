import 'package:flutter/material.dart';

import '../routes/app_routes.dart';
import '../theme/app_colors.dart';
import '../utils/validators.dart';
import '../widgets/back_button_box.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';
import '../widgets/decor_shape.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // TODO: cuando exista la pantalla de código, ir a ella.
      // Por ahora saltamos a Nueva contraseña para poder probar el flujo.
      Navigator.pushNamed(
        context,
        AppRoutes.newPassword,
        arguments: _emailController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned(
            top: -70,
            right: -70,
            child: DecorShape(size: 240, gradient: AppColors.blueGradient),
          ),
          Positioned(
            top: 120,
            right: 24,
            child: DecorShape(size: 16, color: AppColors.yellow),
          ),
          Positioned(
            bottom: -40,
            right: -30,
            child: DecorShape(size: 130, color: const Color(0xFFFDE6C8)),
          ),
          Positioned(
            bottom: -10,
            left: -20,
            child: DecorShape(size: 56, gradient: AppColors.pinkGradient),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BackButtonBox(),
                    const SizedBox(height: 20),
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: AppColors.blueGradient,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.mail_outline,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      '¿Olvidaste tu\ncontraseña?',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Ingresa el correo con el que te registraste y te '
                      'enviaremos un código de 4 dígitos.',
                      style: TextStyle(fontSize: 14, color: AppColors.textGrey),
                    ),
                    const SizedBox(height: 24),
                    CustomInput(
                      label: 'Correo electrónico',
                      hint: 'tu@correo.com',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: Validators.email,
                    ),
                    const SizedBox(height: 20),
                    CustomButton(text: 'Enviar código', onPressed: _submit),
                    const SizedBox(height: 60),
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            '¿La recordaste? ',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textGrey,
                            ),
                          ),
                          GestureDetector(
                            // TODO: ir a Login cuando exista
                            onTap: () => Navigator.maybePop(context),
                            child: const Text(
                              'Inicia sesión',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
