import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // para filtrar solo números y detectar teclas

import '../theme/app_colors.dart';

// Casilla de UN dígito para el código de verificación
class CodeBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode; // controla en cuál casilla está el cursor
  final void Function(String) onChanged;
  final VoidCallback onBackspaceWhenEmpty; // borrar con la casilla vacía

  const CodeBox({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onBackspaceWhenEmpty,
  });

  OutlineInputBorder _borde(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: color, width: 1.5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 64,
      // Focus detecta teclas: si pulsan borrar con la casilla vacía,
      // avisamos a la pantalla para que regrese a la anterior
      child: Focus(
        onKeyEvent: (node, event) {
          if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.backspace &&
              controller.text.isEmpty) {
            onBackspaceWhenEmpty();
            return KeyEventResult.handled;
          }
          return KeyEventResult.ignored;
        },
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1, // un solo carácter
          // Solo permite dígitos del 0 al 9
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
          onChanged: onChanged,
          decoration: InputDecoration(
            counterText: '', // oculta el contador "0/1"
            filled: true,
            fillColor: AppColors.inputFill,
            enabledBorder: _borde(AppColors.inputBorder),
            focusedBorder: _borde(AppColors.primary),
          ),
        ),
      ),
    );
  }
}
