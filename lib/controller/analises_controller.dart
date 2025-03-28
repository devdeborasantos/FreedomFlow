import 'package:fl_chart/fl_chart.dart';
import 'package:get_it/get_it.dart';
import '../controller/extrato_controller.dart';

class AnalisesController {
  final ExtratoController _extratoController = GetIt.instance<ExtratoController>();

  // Método para obter dados dos proventos (garantir que os dados sejam baseados em anos)
  List<FlSpot> get dadosProventos {
    List<FlSpot> spots = [];
    for (int ano = 2023; ano <= 2025; ano++) {
      List<Map<String, dynamic>> proventosAno = _extratoController.obterProventosPorAno(ano);
      double totalProventos = proventosAno.fold(0.0, (sum, item) => sum + item['provento']);
      spots.add(FlSpot(ano.toDouble(), totalProventos));
    }
    return spots;
  }

  // Dados fictícios para o gráfico de variação da rentabilidade
  List<FlSpot> get dadosRentabilidade {
    return [
      FlSpot(2023, 1200.0), // Exemplo de valor para 2023
      FlSpot(2024, 2000.0), // Exemplo de valor para 2024
      FlSpot(2025, 3800.0), // Exemplo de valor para 2025
    ];
  }
}