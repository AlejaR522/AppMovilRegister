import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CustomInput extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const CustomInput({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool _ocultar = true;

  OutlineInputBorder _borde(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: widget.isPassword && _ocultar,
          validator: widget.validator,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: const TextStyle(color: AppColors.textGrey, fontSize: 14),
            filled: true,
            fillColor: AppColors.inputFill,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            enabledBorder: _borde(AppColors.inputBorder),
            focusedBorder: _borde(AppColors.primary),
            errorBorder: _borde(AppColors.error),
            focusedErrorBorder: _borde(AppColors.error),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _ocultar
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.textGrey,
                    ),
                    onPressed: () => setState(() => _ocultar = !_ocultar),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}