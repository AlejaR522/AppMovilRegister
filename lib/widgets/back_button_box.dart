import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class BackButtonBox extends StatelessWidget {
  const BackButtonBox({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.maybePop(context),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.inputBorder),
        ),
        child: const Icon(
          Icons.arrow_back_ios_new,
          size: 16,
          color: AppColors.textDark,
        ),
      ),
    );
  }
}