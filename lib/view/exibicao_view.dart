//
//
//
//
// ESSA TELA NÃO FOI UTILIZADA, MAS DEIXEI AQUI PARA CASO OPTE POR INSERIR NA PARTE 2 DO PROJETO
//
//
//
//

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../controller/cadastro_controller.dart';

class ExibicaoView extends StatefulWidget {
  const ExibicaoView({super.key});

  @override
  State<ExibicaoView> createState() => _ExibicaoViewState();
}

class _ExibicaoViewState extends State<ExibicaoView> {
  final ctrl = GetIt.I.get<CadastroController>();

  @override
  void initState() {
    super.initState();
    ctrl.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Extrato de Proventos', style: TextStyle(color: Color(0xFFEDE5B2))),
        backgroundColor: Colors.grey.shade900,
        iconTheme: const IconThemeData(color: Color(0xFFEDE5B2)),
      ),
      body: Container(
        color: Colors.green.shade900, 
        padding: EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nome: ${ctrl.txtNome.text}',
                    style: TextStyle(
                      color: Color(0xFFEDE5B2), 
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'E-mail: ${ctrl.txtEmail.text}',
                    style: TextStyle(
                      color: Color(0xFFEDE5B2), 
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, 'home'),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFEDE5B2), 
                      foregroundColor: Colors.grey.shade900, 
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    child: Text('Voltar para Login'),
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
