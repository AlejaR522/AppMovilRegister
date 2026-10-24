import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

// Cuadro (o círculo) con degradado y un ícono blanco en el centro.
// Se usa en Login, Código y Home.
class GradientIconBox extends StatelessWidget {
  final IconData icon; // ícono a mostrar
  final double size; // ancho y alto
  final double radius; // redondeo de las esquinas
  final bool circle; // true = círculo en vez de cuadro
  final Gradient gradient; // colores del fondo

  const GradientIconBox({
    super.key,
    required this.icon,
    this.size = 56,
    this.radius = 16,
    this.circle = false,
    this.gradient = AppColors.buttonGradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: gradient,
        shape: circle ? BoxShape.circle : BoxShape.rectangle,
        // borderRadius no puede usarse junto con un círculo
        borderRadius: circle ? null : BorderRadius.circular(radius),
      ),
      // El ícono mide la mitad del cuadro
      child: Icon(icon, color: Colors.white, size: size * 0.5),
    );
  }
}
