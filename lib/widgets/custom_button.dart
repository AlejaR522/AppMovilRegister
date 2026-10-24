import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // null = deshabilitado
  final bool isPrimary;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
  });

  @override
  Widget build(BuildContext context) {
    final habilitado = onPressed != null;

    return Opacity(
      opacity: habilitado ? 1 : 0.5,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          gradient: isPrimary ? AppColors.buttonGradient : null,
          color: isPrimary ? null : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: isPrimary ? null : Border.all(color: AppColors.inputBorder),
          boxShadow: isPrimary && habilitado
              ? [
                  BoxShadow(
                    color: AppColors.pink.withOpacity(0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: onPressed,
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: isPrimary ? Colors.white : AppColors.textDark,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}