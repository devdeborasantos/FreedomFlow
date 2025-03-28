import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../controller/cadastro_controller.dart';

class CadastroView extends StatefulWidget {
  const CadastroView({super.key});

  @override
  State<CadastroView> createState() => _CadastroViewState();
}

class _CadastroViewState extends State<CadastroView> {
  final ctrl = GetIt.I.get<CadastroController>();
  final _formKey = GlobalKey<FormState>();

  bool obscureSenha = true;
  bool obscureConfirmarSenha = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro', style: TextStyle(color: Color(0xFFEDE5B2))),
        backgroundColor: Colors.grey.shade900,
        iconTheme: IconThemeData(color: Color(0xFFEDE5B2)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), 
        ),
      ),
      body: Container(
        color: Colors.green.shade900,
        padding: EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(ctrl.txtNome, 'Nome', ctrl.validarNome),
              _buildTextField(ctrl.txtEmail, 'E-mail', ctrl.validarEmail, TextInputType.emailAddress),
              _buildTextField(ctrl.txtTelefone, 'Telefone', ctrl.validarTelefone, TextInputType.phone),
              _buildPasswordField(ctrl.txtSenha, 'Senha', obscureSenha, () {
                setState(() {
                  obscureSenha = !obscureSenha;
                });
              }),
              _buildPasswordField(ctrl.txtConfirmarSenha, 'Confirmar Senha', obscureConfirmarSenha, () {
                setState(() {
                  obscureConfirmarSenha = !obscureConfirmarSenha;
                });
              }),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ctrl.cadastrar(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFEDE5B2),
                  foregroundColor: Colors.grey.shade900,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: Text('Salvar'),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Voltar para Login',
                  style: TextStyle(color: Color(0xFF7DEB7E), fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String? Function(String) validator, [TextInputType? keyboardType]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Color(0xFFEDE5B2)),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFEDE5B2)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFEDE5B2)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFEDE5B2), width: 2),
          ),
        ),
        style: TextStyle(color: Color(0xFFEDE5B2)),
        validator: (value) {
          String? errorMessage = validator(value!);
          if (errorMessage != null) {
            return errorMessage;
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String label, bool obscureText, VoidCallback onToggle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Color(0xFFEDE5B2)),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFEDE5B2)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFEDE5B2)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFEDE5B2), width: 2),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              obscureText ? Icons.visibility_off : Icons.visibility,
              color: Color(0xFFEDE5B2),
            ),
            onPressed: onToggle,
          ),
        ),
        style: TextStyle(color: Color(0xFFEDE5B2)),
        validator: (value) {
          String? errorMessage = ctrl.validarSenha(value!);
          if (errorMessage != null) {
            return errorMessage;
          }
          return null;
        },
      ),
    );
  }
}
