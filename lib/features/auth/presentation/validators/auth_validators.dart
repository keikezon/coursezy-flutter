String? validateEmail(String? value) {
  if (value == null || value.isEmpty) return 'Informe o email';
  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  if (!emailRegex.hasMatch(value)) return 'Email inválido';
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) return 'Informe a senha';
  if (value.length < 6) return 'Senha deve ter pelo menos 6 caracteres';
  return null;
}
