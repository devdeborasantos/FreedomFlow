import 'package:flutter/material.dart';
import '../controller/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController controller = HomeController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green.shade900, 
        padding: EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'img/logoFF02.png', 
                    width: 300,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 50),

                  TextFormField(
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'E-mail',
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
                    validator: (value) => controller.validarEmail(value!),
                  ),
                  SizedBox(height: 15),

                  TextFormField(
                    controller: controller.senhaController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Senha',
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
                    validator: (value) => controller.validarSenha(value!),
                  ),
                  SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        controller.login(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFEDE5B2), 
                      foregroundColor: Colors.grey.shade900, 
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    child: Text('Entrar'),
                  ),
                  SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, 'cadastro'),
                        child: Text(
                          'Cadastrar-se',
                          style: TextStyle(color: Color(0xFF7DEB7E)), 
                        ),
                      ),
                      Text(
                        '|',
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, 'esqueceu_senha'),
                        child: Text(
                          'Esqueceu a senha?',
                          style: TextStyle(color: Color(0xFF7DEB7E)), 
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 100),

                  TextButton(
                    onPressed: () => controller.abrirSobre(context),
                    child: Text(
                      'Sobre',
                      style: TextStyle(
                        color: Color(0xFFEDE5B2),
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
