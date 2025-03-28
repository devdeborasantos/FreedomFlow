import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../controller/esqueceu_controller.dart';

class EsqueceuView extends StatefulWidget {
  const EsqueceuView({super.key});

  @override
  State<EsqueceuView> createState() => _EsqueceuViewState();
}

class _EsqueceuViewState extends State<EsqueceuView> {
  final ctrl = GetIt.I.get<EsqueceuController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recuperar Senha', style: TextStyle(color: Color(0xFFEDE5B2))),
        backgroundColor:  Colors.grey.shade900,
        iconTheme: IconThemeData(color: Color(0xFFEDE5B2)),
      ),
      body: Container(
        color: Colors.green.shade900,
        padding: EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Informe seu e-mail cadastrado para recuperar sua senha.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Color(0xFFEDE5B2)),
              ),
              SizedBox(height: 20),
              _buildTextField(ctrl.txtEmail, 'E-mail', ctrl.validarEmail, TextInputType.emailAddress),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ctrl.enviarRecuperacao(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFEDE5B2),
                  foregroundColor: Colors.grey.shade900,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: Text('Recuperar Senha'),
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

  Widget _buildTextField(TextEditingController controller, String label, String? Function(String) validator, [TextInputType? keyboardType, bool obscureText = false]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
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
        ),
        style: TextStyle(color: Color(0xFFEDE5B2)),
        validator: (value) {
          String? errorMessage = validator(value!);
          return errorMessage ?? null; // Retorna o erro, caso exista
        },
      ),
    );
  }
}
