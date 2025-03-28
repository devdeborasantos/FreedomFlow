import 'package:flutter/material.dart';

class EsqueceuController {
  final txtEmail = TextEditingController();

  String? validarEmail(String value) {
    if (value.isEmpty) return 'E-mail não pode ser vazio';
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return 'E-mail inválido';
    return null;
  }

  void enviarRecuperacao(BuildContext context) {
    if (validarEmail(txtEmail.text) == null) {
      // Simulação de envio de e-mail
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Instruções enviadas para o e-mail ${txtEmail.text}')),
      );
      Navigator.pop(context); // Tela anterior (home)
    }
  }
}
