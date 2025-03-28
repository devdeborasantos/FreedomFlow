import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get_it/get_it.dart';
import '../controller/analises_controller.dart';
import 'package:intl/intl.dart'; // Para formatação do valor monetário

class AnalisesView extends StatelessWidget {
  final AnalisesController controller = GetIt.instance<AnalisesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Análises', style: TextStyle(color: Color(0xFFEDE5B2))),
        backgroundColor: Colors.grey.shade900, 
        iconTheme: IconThemeData(color: Color(0xFFEDE5B2)),
      ),
      body: Container(
        color: Colors.green.shade900, 
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Variação dos Proventos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFEDE5B2), 
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            _buildGrafico(controller.dadosProventos, Color(0xFF7DEB7E)),

            SizedBox(height: 20),

            Text(
              'Variação da Rentabilidade',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFEDE5B2),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            _buildGrafico(controller.dadosRentabilidade, Color(0xFF7DEB7E)),
          ],
        ),
      ),
    );
  }

  // Método para construir os gráficos
  Widget _buildGrafico(List<FlSpot> dados, Color cor) {
    return SizedBox(
      height: 300, 
      child: LineChart(
        LineChartData(
          backgroundColor: Colors.green.shade900, 
          gridData: FlGridData(show: true, drawVerticalLine: false), // Sem linhas verticais repetidas
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 60, // Espaço reservado para os títulos do eixo Y
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      'R\$ ${NumberFormat('#,##0').format(value)}',
                      style: TextStyle(fontSize: 12, color: Color(0xFFEDE5B2)), 
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 22, // Espaço reservado para os títulos do eixo X
                getTitlesWidget: (value, meta) {
                  // Mostra apenas os anos 2023, 2024, 2025 no eixo X
                  if (value == 2023 || value == 2024 || value == 2025) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        value.toInt().toString(), // Exibe os anos no eixo X
                        style: TextStyle(fontSize: 12, color: Color(0xFFEDE5B2)), 
                      ),
                    );
                  }
                  return Text('');
                },
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),  // Desabilita a legenda à direita
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),  // Desabilita a legenda no topo
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Color(0xFFEDE5B2), width: 1), 
          ),
          lineBarsData: [
            LineChartBarData(
              spots: dados,
              isCurved: true,
              color: cor, // Cor do gráfico
              barWidth: 4, // Largura da linha do gráfico
              isStrokeCapRound: true,
              belowBarData: BarAreaData(show: false),
            ),
          ],
          minY: 0,
          maxY: 5000, // preciso de uma formula para garantir que esse valor seja o maior encontrado entre os anos existentes
        ),
      ),
    );
  }
}
