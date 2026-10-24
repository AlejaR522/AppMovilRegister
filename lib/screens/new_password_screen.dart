import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/back_button_box.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';
import '../widgets/decor_shape.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  // Los 3 requisitos, calculados en tiempo real
  bool get _tiene8 => _passwordController.text.length >= 8;
  bool get _tieneMayuscula => RegExp(r'[A-Z]').hasMatch(_passwordController.text);
  bool get _tieneNumero => RegExp(r'[0-9]').hasMatch(_passwordController.text);
  bool get _coinciden =>
      _confirmController.text.isNotEmpty &&
      _confirmController.text == _passwordController.text;

  bool get _todoValido =>
      _tiene8 && _tieneMayuscula && _tieneNumero && _coinciden;

  void _submit() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('¡Contraseña restablecida con éxito!')),
    );
    // TODO: cuando exista Login, volver a Login con el mensaje de éxito
  }

  Widget _requisito(String texto, bool cumplido) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(
            cumplido ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 18,
            color: cumplido ? AppColors.success : AppColors.textGrey,
          ),
          const SizedBox(width: 8),
          Text(
            texto,
            style: TextStyle(
              fontSize: 13,
              color: cumplido ? AppColors.textDark : AppColors.textGrey,
            ),
          ),
        ],
      ),
    );
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
            child: DecorShape(size: 240, gradient: AppColors.pinkGradient),
          ),
          Positioned(
            top: 130,
            right: 24,
            child: DecorShape(size: 16, color: AppColors.yellow),
          ),
          Positioned(
            bottom: -40,
            left: -40,
            child: DecorShape(size: 130, color: const Color(0xFFBFDBFE)),
          ),
          Positioned(
            bottom: 10,
            right: -10,
            child: DecorShape(
              size: 64,
              type: ShapeType.square,
              gradient: AppColors.orangeGradient,
              rotation: 0.3,
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BackButtonBox(),
                  const SizedBox(height: 16),
                  // Etiqueta "Código verificado"
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCFCE7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check, size: 14, color: AppColors.success),
                        SizedBox(width: 4),
                        Text(
                          'Código verificado',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF15803D),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: AppColors.pinkGradient,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.lock_outline,
                        color: Colors.white, size: 28),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Crea una nueva\ncontraseña',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tu nueva contraseña debe ser diferente a las que '
                    'usaste antes.',
                    style: TextStyle(fontSize: 14, color: AppColors.textGrey),
                  ),
                  const SizedBox(height: 20),
                  CustomInput(
                    label: 'Nueva contraseña',
                    hint: '••••••••',
                    controller: _passwordController,
                    isPassword: true,
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 14),
                  CustomInput(
                    label: 'Confirmar contraseña',
                    hint: '••••••••',
                    controller: _confirmController,
                    isPassword: true,
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 14),
                  _requisito('Mínimo 8 caracteres', _tiene8),
                  _requisito('Al menos una mayúscula', _tieneMayuscula),
                  _requisito('Al menos un número', _tieneNumero),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Restablecer contraseña',
                    onPressed: _todoValido ? _submit : null,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}