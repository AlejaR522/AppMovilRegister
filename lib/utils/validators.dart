class Validators {
  static String? required(String? value, String mensaje) {
    if (value == null || value.trim().isEmpty) return mensaje;
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Ingresa tu correo';
    }
    final regex = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,}$');
    if (!regex.hasMatch(value.trim())) {
      return 'Correo no válido (ej: usuario@dominio.com)';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Ingresa una contraseña';
    if (value.length < 8) return 'Mínimo 8 caracteres';
    return null;
  }

  static String? confirmPassword(String? value, String original) {
    if (value == null || value.isEmpty) return 'Confirma tu contraseña';
    if (value != original) return 'Las contraseñas no coinciden';
    return null;
  }
}