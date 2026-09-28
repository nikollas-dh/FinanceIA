import 'package:flutter/material.dart';

class Validators {
  static String? obrigatorio(String? v, [String campo = 'Campo']) =>
      (v == null || v.trim().isEmpty) ? '$campo é obrigatório' : null;

  static String? email(String? v) {
    final erro = obrigatorio(v, 'E-mail');
    if (erro != null) return erro;
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v!.trim());
    return ok ? null : 'E-mail inválido';
  }

  static String? senha(String? v) {
    final erro = obrigatorio(v, 'Senha');
    if (erro != null) return erro;
    return v!.length < 6 ? 'A senha deve ter ao menos 6 caracteres' : null;
  }

  static String? Function(String?) confirmacao(TextEditingController senha) =>
      (v) {
        final erro = obrigatorio(v, 'Confirmação');
        if (erro != null) return erro;
        return v != senha.text ? 'As senhas não conferem' : null;
      };

  static String? valor(String? v) {
    final erro = obrigatorio(v, 'Valor');
    if (erro != null) return erro;
    final n = double.tryParse(v!.replaceAll(',', '.'));
    return (n == null || n <= 0) ? 'Informe um valor maior que zero' : null;
  }
}
