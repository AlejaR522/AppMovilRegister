import 'package:flutter/material.dart';

enum ShapeType { circle, ring, square }

class DecorShape extends StatelessWidget {
  final double size;
  final ShapeType type;
  final Gradient? gradient;
  final Color? color;
  final double rotation; // en radianes

  const DecorShape({
    super.key,
    required this.size,
    this.type = ShapeType.circle,
    this.gradient,
    this.color,
    this.rotation = 0,
  });

  @override
  Widget build(BuildContext context) {
    final esAro = type == ShapeType.ring;

    return Transform.rotate(
      angle: rotation,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: type == ShapeType.square ? BoxShape.rectangle : BoxShape.circle,
          borderRadius:
              type == ShapeType.square ? BorderRadius.circular(size * 0.3) : null,
          gradient: esAro ? null : gradient,
          color: esAro ? null : color,
          border: esAro ? Border.all(color: color!, width: 5) : null,
        ),
      ),
    );
  }
}