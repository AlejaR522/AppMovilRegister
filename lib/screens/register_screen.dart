import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../utils/validators.dart';
import '../widgets/back_button_box.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';
import '../widgets/decor_shape.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _acceptTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // TODO: cuando exista Home:
      // Navigator.pushNamed(context, AppRoutes.home, arguments: _emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cuenta creada para ${_emailController.text}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Formas decorativas
          Positioned(
            top: -60,
            right: -60,
            child: DecorShape(size: 220, gradient: AppColors.orangeGradient),
          ),
          Positioned(
            top: 130,
            right: 50,
            child: DecorShape(
                size: 40, type: ShapeType.ring, color: AppColors.primary),
          ),
          Positioned(
            top: 180,
            right: 20,
            child: DecorShape(size: 14, color: AppColors.yellow),
          ),
          Positioned(
            bottom: -50,
            right: -40,
            child: DecorShape(size: 150, color: const Color(0xFFBFDBFE)),
          ),
          Positioned(
            bottom: -20,
            left: -20,
            child: DecorShape(size: 60, gradient: AppColors.pinkGradient),
          ),

          // Contenido
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BackButtonBox(),
                    const SizedBox(height: 24),
                    const Text(
                      'Crea tu cuenta',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Completa tus datos para empezar',
                      style: TextStyle(fontSize: 14, color: AppColors.textGrey),
                    ),
                    const SizedBox(height: 20),
                    CustomInput(
                      label: 'Nombre completo',
                      hint: 'Juan Pérez',
                      controller: _nameController,
                      validator: (v) =>
                          Validators.required(v, 'Ingresa tu nombre'),
                    ),
                    const SizedBox(height: 14),
                    CustomInput(
                      label: 'Correo electrónico',
                      hint: 'tu@correo.com',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: Validators.email,
                    ),
                    const SizedBox(height: 14),
                    CustomInput(
                      label: 'Contraseña',
                      hint: 'Mínimo 8 caracteres',
                      controller: _passwordController,
                      isPassword: true,
                      validator: Validators.password,
                    ),
                    const SizedBox(height: 14),
                    CustomInput(
                      label: 'Confirmar contraseña',
                      hint: 'Repite tu contraseña',
                      controller: _confirmController,
                      isPassword: true,
                      validator: (v) => Validators.confirmPassword(
                          v, _passwordController.text),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Checkbox(
                          value: _acceptTerms,
                          activeColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          onChanged: (v) =>
                              setState(() => _acceptTerms = v ?? false),
                        ),
                        const Expanded(
                          child: Text.rich(
                            TextSpan(
                              text: 'Acepto los ',
                              style: TextStyle(
                                  fontSize: 12, color: AppColors.textGrey),
                              children: [
                                TextSpan(
                                  text: 'Términos y condiciones',
                                  style: TextStyle(color: AppColors.primary),
                                ),
                                TextSpan(text: ' y la '),
                                TextSpan(
                                  text: 'Política de privacidad',
                                  style: TextStyle(color: AppColors.primary),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    CustomButton(
                      text: 'Crear cuenta',
                      onPressed: _acceptTerms ? _submit : null,
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            '¿Ya tienes cuenta? ',
                            style: TextStyle(
                                fontSize: 13, color: AppColors.textGrey),
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