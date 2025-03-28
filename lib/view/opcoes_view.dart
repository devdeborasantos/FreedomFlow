import 'package:flutter/material.dart';
import '../controller/opcoes_controller.dart';

class OpcoesView extends StatefulWidget {
  const OpcoesView({super.key});

  @override
  State<OpcoesView> createState() => _OpcoesViewState();
}

class _OpcoesViewState extends State<OpcoesView> {
  final OpcoesController controller = OpcoesController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Opções', style: TextStyle(color: Color(0xFFEDE5B2))),
        backgroundColor: Colors.grey.shade900, 
        iconTheme: IconThemeData(color: Color(0xFFEDE5B2)),
      ),
      body: Container(
        color: Colors.green.shade900, 
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // 2 colunas
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            _buildGridItem(context, 'Resumo', Icons.pie_chart, 'resumo'),
            _buildGridItem(context, 'Ativos', Icons.list_alt_outlined, 'ativos'),
            _buildGridItem(context, 'Análises', Icons.bar_chart, 'analises'),
            _buildGridItem(context, 'Extrato', Icons.receipt_long, 'extrato'),
          ],
        ),
      ),
    );
  }

  // Função para construir os itens do grid
  Widget _buildGridItem(BuildContext context, String titulo, IconData icone, String rota) {
    return GestureDetector(
      onTap: () => controller.navegarPara(context, rota),
      child: Card(
        color: Color(0xFFEDE5B2), 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icone, size: 50, color: Colors.grey.shade900), 
            SizedBox(height: 10),
            Text(
              titulo,
              style: TextStyle(color: Colors.grey.shade900, fontSize: 18, fontWeight: FontWeight.bold), 
            ),
          ],
        ),
      ),
    );
  }
}
