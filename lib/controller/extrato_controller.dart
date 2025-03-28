import 'package:flutter/material.dart';

class ExtratoController extends ChangeNotifier {
  // Dados de proventos de 2023 até março de 2025
  final Map<DateTime, double> proventos = {
    DateTime(2023, 1, 1): 100.50,
    DateTime(2023, 2, 1): 130.75,
    DateTime(2023, 3, 1): 170.30,
    DateTime(2023, 4, 1): 90.00,
    DateTime(2023, 5, 1): 180.25,
    DateTime(2023, 6, 1): 230.80,
    DateTime(2023, 7, 1): 290.60,
    DateTime(2023, 8, 1): 260.45,
    DateTime(2023, 9, 1): 210.20,
    DateTime(2023, 10, 1): 200.10,
    DateTime(2023, 11, 1): 210.90,
    DateTime(2023, 12, 1): 640.40,
    DateTime(2024, 1, 1): 120.50,
    DateTime(2024, 2, 1): 150.75,
    DateTime(2024, 3, 1): 180.30,
    DateTime(2024, 4, 1): 90.00,
    DateTime(2024, 5, 1): 200.25,
    DateTime(2024, 6, 1): 250.80,
    DateTime(2024, 7, 1): 300.60,
    DateTime(2024, 8, 1): 280.45,
    DateTime(2024, 9, 1): 210.20,
    DateTime(2024, 10, 1): 190.10,
    DateTime(2024, 11, 1): 220.90,
    DateTime(2024, 12, 1): 960.40,
    DateTime(2025, 1, 1): 230.00, 
    DateTime(2025, 2, 1): 180.00,
    DateTime(2025, 3, 1): 250.30,
    DateTime(2025, 4, 1): 340.50,
    DateTime(2025, 5, 1): 660.80, 
  };

  // Método para obter os proventos formatados
  String obterProventoFormatado(DateTime data) {
    return 'R\$ ${proventos[data]?.toStringAsFixed(2) ?? "0.00"}';
  }

  // Método para obter os anos disponíveis nos dados
  List<int> obterAnosDisponiveis() {
    return proventos.keys.map((data) => data.year).toSet().toList()..sort();
  }

  // Método para retornar a lista de proventos de acordo com o ano selecionado
  List<Map<String, dynamic>> obterProventosPorAno(int ano) {
    return proventos.entries
        .where((entry) => entry.key.year == ano)
        .map((entry) => {'data': entry.key, 'provento': entry.value})
        .toList();
  }

  // Método para calcular a soma dos proventos de um ano
  double calcularTotalProventosPorAno(int ano) {
    return proventos.entries
        .where((entry) => entry.key.year == ano)
        .fold(0.0, (sum, entry) => sum + entry.value);
  }
}
