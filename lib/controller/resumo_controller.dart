import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'ativos_controller.dart';

class ResumoController {
  final AtivosController ativosController = GetIt.I<AtivosController>();

  // Método para obter os dados do gráfico
  List<PieChartSectionData> obterDadosGrafico(BuildContext context) {
    // Aqui, estamos utilizando o ativosController, que será atualizado com o ChangeNotifier
    Map<String, double> porcentagens = ativosController.calcularPorcentagens();

    return [
      PieChartSectionData(
        value: porcentagens['Ação'] ?? 0.0,
        title: '${porcentagens['Ação']?.toStringAsFixed(1)}%',
      ),
      PieChartSectionData(
        value: porcentagens['Fundo Imobiliário'] ?? 0.0,
        title: '${porcentagens['Fundo Imobiliário']?.toStringAsFixed(1)}%',
      ),
      PieChartSectionData(
        value: porcentagens['Criptomoeda'] ?? 0.0,
        title: '${porcentagens['Criptomoeda']?.toStringAsFixed(1)}%',
      ),
      PieChartSectionData(
        value: porcentagens['Título Público'] ?? 0.0,
        title: '${porcentagens['Título Público']?.toStringAsFixed(1)}%',
      ),
      PieChartSectionData(
        value: porcentagens['Poupança'] ?? 0.0,
        title: '${porcentagens['Poupança']?.toStringAsFixed(1)}%',
      ),
    ];
  }

  // Método para calcular o valor total da carteira em R$
  String calcularTotalEmReais() {
    double total = ativosController.totalValor; 
    return 'R\$ ${total.toStringAsFixed(2)}';
  }
}
