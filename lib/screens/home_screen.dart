import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/decor_shape.dart';
import '../widgets/gradient_icon_box.dart';

// StatelessWidget: Home no cambia, solo muestra datos
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Recibe el correo enviado desde Login o Registro
    final args = ModalRoute.of(context)?.settings.arguments;
    final email = args is String ? args : 'usuario@correo.com';
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // ---------- Formas decorativas ----------
          Positioned(
            top: -110,
            right: -90,
            child: DecorShape(
              size: size.width * 0.8,
              gradient: AppColors.buttonGradient,
            ),
          ),
          Positioned(
            top: 120,
            left: 36,
            child: DecorShape(size: 30, color: AppColors.yellow),
          ),
          Positioned(
            top: size.height * 0.4,
            left: -22,
            child: DecorShape(
              size: 44,
              type: ShapeType.ring,
              color: const Color(0xFFF472B6),
            ),
          ),
          Positioned(
            bottom: size.height * 0.04,
            left: -80,
            child: DecorShape(size: 210, gradient: AppColors.blueGradient),
          ),
          Positioned(
            bottom: size.height * 0.2,
            right: -10,
            child: DecorShape(
              size: 62,
              type: ShapeType.square,
              gradient: AppColors.orangeGradient,
              rotation: 0.4,
            ),
          ),

          // ---------- Contenido ----------
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    // Ocupa solo lo necesario y queda centrado
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Avatar circular
                      const GradientIconBox(
                        icon: Icons.person_outline_rounded,
                        size: 96,
                        circle: true,
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        '¡Bienvenido!',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Etiqueta con el correo del usuario
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEDE9FE), // lila claro
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.mail_outline_rounded,
                              size: 18,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 8),
                            // Flexible + ellipsis: si el correo es muy largo
                            // se corta con "..." en vez de desbordarse
                            Flexible(
                              child: Text(
                                email,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 56),

                      // Cerrar sesión: vuelve a Login y borra el historial
                      CustomButton(
                        text: 'Cerrar sesión',
                        onPressed: () => Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/',
                          (route) => false, // false = borra todas las pantallas anteriores
                        ),
                      ),
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
