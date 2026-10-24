import 'dart:async'; // para usar Timer (el contador)

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/back_button_box.dart';
import '../widgets/code_box.dart';
import '../widgets/custom_button.dart';
import '../widgets/decor_shape.dart';
import '../widgets/gradient_icon_box.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({super.key});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  static const _totalSeconds = 45; // duración del contador

  // 4 controllers (uno por casilla) y 4 focus nodes (para mover el cursor)
  final _controllers = List.generate(4, (_) => TextEditingController());
  final _focusNodes = List.generate(4, (_) => FocusNode());

  Timer? _timer;
  int _seconds = _totalSeconds;

  // ¿Las 4 casillas tienen un dígito?
  bool get _complete => _controllers.every((c) => c.text.isNotEmpty);
  // ¿Ya llegó el contador a cero?
  bool get _canResend => _seconds == 0;

  // Convierte los segundos a formato 00:45
  String get _timeText {
    final m = (_seconds ~/ 60).toString().padLeft(2, '0');
    final s = (_seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  void initState() {
    super.initState();
    _startTimer(); // el contador arranca al abrir la pantalla
  }

  // Inicia (o reinicia) el contador
  void _startTimer() {
    _timer?.cancel(); // evita tener dos contadores a la vez
    _seconds = _totalSeconds;
    // Timer.periodic ejecuta la función cada 1 segundo
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_seconds <= 1) {
        t.cancel(); // llegó a cero: se detiene
        setState(() => _seconds = 0);
      } else {
        setState(() => _seconds--); // resta 1 y redibuja
      }
    });
  }

  @override
  void dispose() {
    // Importante: liberar todo al salir de la pantalla
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  // Se ejecuta cuando cambia el texto de una casilla
  void _onDigitChanged(int index, String value) {
    if (value.isNotEmpty && index < 3) {
      _focusNodes[index + 1].requestFocus(); // escribió: pasa a la siguiente
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus(); // borró: regresa a la anterior
    }
    setState(() {}); // redibuja para habilitar/deshabilitar el botón
  }

  // Borrar con la casilla ya vacía: limpia y vuelve a la anterior
  void _onBackspaceWhenEmpty(int index) {
    if (index > 0) {
      _controllers[index - 1].clear();
      _focusNodes[index - 1].requestFocus();
      setState(() {});
    }
  }

  // Reenviar código: limpia las casillas y reinicia el contador
  void _resend() {
    for (final c in _controllers) {
      c.clear();
    }
    _focusNodes[0].requestFocus();
    _startTimer();
    setState(() {});
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Código reenviado')));
  }

  @override
  Widget build(BuildContext context) {
    // Lee el correo que llegó desde la pantalla anterior (arguments)
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
              size: size.width * 0.75,
              gradient: AppColors.orangeGradient,
            ),
          ),
          Positioned(
            top: size.height * 0.2,
            right: 28,
            child: DecorShape(
              size: 36,
              type: ShapeType.ring,
              color: const Color(0xFF8B5CF6),
            ),
          ),
          Positioned(
            bottom: -60,
            right: -40,
            child: DecorShape(size: 190, gradient: AppColors.blueGradient),
          ),
          Positioned(
            bottom: -20,
            left: -20,
            child: DecorShape(
              size: 60,
              type: ShapeType.square,
              gradient: AppColors.buttonGradient,
              rotation: 0.3,
            ),
          ),

          // ---------- Contenido ----------
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      const BackButtonBox(), // vuelve a Recuperar contraseña
                      const SizedBox(height: 28),
                      const GradientIconBox(
                        icon: Icons.verified_user_outlined,
                        gradient: AppColors.orangeGradient,
                        size: 54,
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Verifica tu correo',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Escribe el código de 4 dígitos que enviamos a',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textGrey,
                        ),
                      ),
                      // Correo que el usuario escribió antes
                      Text(
                        email,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Las 4 casillas, generadas con un ciclo
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          4,
                          (i) => CodeBox(
                            controller: _controllers[i],
                            focusNode: _focusNodes[i],
                            onChanged: (v) => _onDigitChanged(i, v),
                            onBackspaceWhenEmpty: () =>
                                _onBackspaceWhenEmpty(i),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Contador / enlace para reenviar
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              '¿No te llegó? ',
                              style: TextStyle(
                                color: AppColors.textGrey,
                                fontSize: 13,
                              ),
                            ),
                            // Si el contador llegó a cero, muestra el enlace;
                            // si no, muestra el tiempo restante
                            if (_canResend)
                              GestureDetector(
                                onTap: _resend,
                                child: const Text(
                                  'Reenviar código',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                              )
                            else
                              Text(
                                'Reenviar código en $_timeText',
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Solo se habilita con las 4 casillas llenas
                      CustomButton(
                        text: 'Siguiente',
                        onPressed: _complete
                            ? () =>
                                  Navigator.pushNamed(context, '/new-password')
                            : null,
                      ),
                      const SizedBox(height: 24),
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
