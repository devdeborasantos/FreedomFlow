import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get_it/get_it.dart';
import '../controller/ativos_controller.dart';
import '../controller/resumo_controller.dart';

class ResumoView extends StatelessWidget {
  const ResumoView({super.key});

  @override
  Widget build(BuildContext context) {
    // Obter o ResumoController usando GetIt
    final resumoController = ResumoController();
    final ativosController = GetIt.I<AtivosController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumo da Carteira', style: TextStyle(color: Color(0xFFEDE5B2))),
        backgroundColor: Colors.grey.shade900,
        iconTheme: const IconThemeData(color: Color(0xFFEDE5B2)),
      ),
      body: Container(
        color: Colors.green.shade900,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Distribuição da Carteira',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFEDE5B2)),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 300,
              child: PieChart(
                PieChartData(
                  sections: _obterDadosGrafico(ativosController),
                  sectionsSpace: 2,
                  centerSpaceRadius: 50,
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Legenda do Gráfico
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LegendItem(color: Colors.yellowAccent.shade100, text: 'Ações (${ativosController.calcularPorcentagens()['Ação']?.toStringAsFixed(1)}%)'),
                LegendItem(color: Color(0xFFFFE066), text: 'Fundos Imobiliários (${ativosController.calcularPorcentagens()['Fundo Imobiliário']?.toStringAsFixed(1)}%)'),
                LegendItem(color: Color(0xFFFFD700), text: 'Criptomoedas (${ativosController.calcularPorcentagens()['Criptomoeda']?.toStringAsFixed(1)}%)'),
                LegendItem(color: Color(0xFF7DEB7E), text: 'Títulos Públicos (${ativosController.calcularPorcentagens()['Título Público']?.toStringAsFixed(1)}%)'),
                LegendItem(color: Colors.lightGreenAccent, text: 'Poupança (${ativosController.calcularPorcentagens()['Poupança']?.toStringAsFixed(1)}%)'),
              ],
            ),
            const SizedBox(height: 20),
            // Card com o valor total da carteira
            Card(
              color: Colors.green.shade800,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Valor Total da Carteira:',
                      style: TextStyle(color: Color(0xFFEDE5B2), fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      resumoController.calcularTotalEmReais(),
                      style: const TextStyle(color: Color(0xFFEDE5B2), fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _obterDadosGrafico(AtivosController ativosController) {
    Map<String, double> porcentagens = ativosController.calcularPorcentagens();

    return [
      _buildSection('Ação', porcentagens['Ação'] ?? 0.0, Colors.yellowAccent.shade100),
      _buildSection('Fundo Imobiliário', porcentagens['Fundo Imobiliário'] ?? 0.0, Color(0xFFFFE066)),
      _buildSection('Criptomoeda', porcentagens['Criptomoeda'] ?? 0.0, Color(0xFFFFD700)),
      _buildSection('Título Público', porcentagens['Título Público'] ?? 0.0, Color(0xFF7DEB7E)),
      _buildSection('Poupança', porcentagens['Poupança'] ?? 0.0, Colors.lightGreenAccent),
    ];
  }

  PieChartSectionData _buildSection(String title, double value, Color color) {
    return PieChartSectionData(
      value: value,
      title: '${value.toStringAsFixed(1)}%',
      color: color,
      radius: 50,
      titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
    );
  }
}

// Widget para a legenda
class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItem({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(width: 16, height: 16, color: color),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(color: Color(0xFFEDE5B2))),
        ],
      ),
    );
  }
}
