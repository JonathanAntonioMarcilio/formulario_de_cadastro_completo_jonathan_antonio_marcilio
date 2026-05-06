class Validators {

  // Nome ==========================================================================================

  static String? validarNome(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Nome obrigatório';
  }

  if (value.trim().length < 3) {
    return 'Digite o nome completo';
  }

  return null;
  }

  // Email =========================================================================================

  static String? validarEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email obrigatório';
    }

    final regex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (!regex.hasMatch(value)) {
      return 'Email inválido';
    }

    return null;
  }

  // CPF ===========================================================================================

  static String? validarCPF(String? value) {
    if (value == null || value.isEmpty) {
      return 'CPF obrigatório';
    }

    final cpf = value.replaceAll(RegExp(r'[^0-9]'), '');

    if (cpf.length != 11) {
      return 'CPF inválido';
    }

    return null;
  }

  // Telefone ======================================================================================

  static String? validarTelefone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Telefone obrigatório';
    }

    final telefone = value.replaceAll(RegExp(r'[^0-9]'), '');

    if (telefone.length < 10 || telefone.length > 11) {
      return 'Telefone inválido';
    }

    return null;
  }

  // Senha =========================================================================================

  static String? validarSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Senha obrigatória';
    }

    if (value.length < 6) {
      return 'Mínimo de 6 caracteres';
    }

    return null;
  }

  // Confirmar Senha ===============================================================================

  static String? validarConfirmacaoSenha(
    String? value,
    String senha,
  ) {
    if (value == null || value.isEmpty) {
      return 'Confirme sua senha';
    }

    if (value != senha) {
      return 'As senhas não coincidem';
    }

    return null;
  }
}