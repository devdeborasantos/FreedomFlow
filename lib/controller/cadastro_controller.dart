import 'package:flutter/material.dart';

class CadastroController extends ChangeNotifier {
  final txtNome = TextEditingController();
  final txtEmail = TextEditingController();
  final txtTelefone = TextEditingController();
  final txtSenha = TextEditingController();
  final txtConfirmarSenha = TextEditingController();

  String? validarNome(String value) {
    if (value.isEmpty) return 'Nome não pode ser vazio';
    if (value.length < 3) return 'Nome muito curto';
    return null;
  }

  String? validarEmail(String value) {
    if (value.isEmpty) return 'E-mail não pode ser vazio';
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return 'E-mail inválido';
    return null;
  }

  String? validarTelefone(String value) {
    if (value.isEmpty) return 'Telefone não pode ser vazio';
    if (!RegExp(r'^\d{10,11}$').hasMatch(value)) return 'Telefone inválido';
    return null;
  }

  String? validarSenha(String value) {
    if (value.isEmpty) return 'Senha não pode ser vazia';
    if (value.length < 6) return 'Senha deve ter pelo menos 6 caracteres';
    return null;
  }

  String? validarConfirmacaoSenha(String value) {
    if (value.isEmpty) return 'Confirme sua senha';
    if (value != txtSenha.text) return 'As senhas não coincidem';
    return null;
  }

  void cadastrar(BuildContext context) {
    if (validarNome(txtNome.text) == null &&
        validarEmail(txtEmail.text) == null &&
        validarTelefone(txtTelefone.text) == null &&
        validarSenha(txtSenha.text) == null &&
        validarConfirmacaoSenha(txtConfirmarSenha.text) == null) {
      // Aqui pode enviar os dados para o backend ou salvar localmente ===> verificar na P2
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Cadastro realizado com sucesso!')));
      Navigator.pushNamed(context, 'home');
    }
  }
}
