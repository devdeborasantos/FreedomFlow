import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../controller/sobre_controller.dart';

class SobreView extends StatelessWidget {
  SobreView({super.key});

  final ctrl = GetIt.I.get<SobreController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre FreedomFlow', style: TextStyle(color: Color(0xFFEDE5B2))),
        backgroundColor:Colors.grey.shade900,
        iconTheme: IconThemeData(color: Color(0xFFEDE5B2)),
      ),
      body: Container(
        color: Colors.green.shade900,  
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Objetivos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF7DEB7E)),
            ),
            SizedBox(height: 10),
            Text(
              ctrl.objetivo,
              style: TextStyle(fontSize: 16, color: Color(0xFFEDE5B2)),
            ),
            SizedBox(height: 20),
            Text(
              'Desenvolvido por',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF7DEB7E)),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: ctrl.equipe
                  .map((integrante) => Text(
                        "$integrante",
                        style: TextStyle(fontSize: 16, color: Color(0xFFEDE5B2)),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
