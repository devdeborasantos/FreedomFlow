import 'package:flutter/material.dart';

class HomeController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  String? validarEmail(String value) {
    if (value.isEmpty) {
      return 'O e-mail não pode estar vazio';
    }
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$') // Formato xxx@xxx.xxx
        .hasMatch(value)) {
      return 'Digite um e-mail válido';
    }
    return null;
  }

  String? validarSenha(String value) {
    if (value.isEmpty) {
      return 'A senha não pode estar vazia';
    }
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }

  void login(BuildContext context) {
    final email = emailController.text.trim();
    final senha = senhaController.text.trim();

    final emailErro = validarEmail(email);
    final senhaErro = validarSenha(senha);

    if (emailErro == null && senhaErro == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login bem-sucedido!')),
      );
      Navigator.pushNamed(context, 'opcoes');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(emailErro ?? senhaErro!)),
      );
    }
  }

  void abrirSobre(BuildContext context) {
    Navigator.pushNamed(context, 'sobre');
  }
}
