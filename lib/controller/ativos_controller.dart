import 'package:flutter/material.dart';

class AtivosController extends ChangeNotifier {
  // Lista de ativos (inicialização de dados para exemplo)
  final List<Map<String, dynamic>> ativos = [
    {'nome': 'PETR4', 'tipo': 'Ação', 'quantidade': 100, 'valor': 100},
    {'nome': 'VALE3', 'tipo': 'Ação', 'quantidade': 50, 'valor': 200},
    {'nome': 'ITUB4', 'tipo': 'Ação', 'quantidade': 30, 'valor': 500},
    {'nome': 'FII KNRI11', 'tipo': 'Fundo Imobiliário', 'quantidade': 10, 'valor': 300},
    {'nome': 'FII HGLG11', 'tipo': 'Fundo Imobiliário', 'quantidade': 15, 'valor': 400},
    {'nome': 'FII VISC11', 'tipo': 'Fundo Imobiliário', 'quantidade': 7, 'valor': 600},
    {'nome': 'Bitcoin', 'tipo': 'Criptomoeda', 'quantidade': 1, 'valor': 250},
    {'nome': 'Ethereum', 'tipo': 'Criptomoeda', 'quantidade': 3, 'valor': 960},
    {'nome': 'Tesouro Selic', 'tipo': 'Título Público', 'quantidade': 10, 'valor': 420},
    {'nome': 'Tesouro IPCA+', 'tipo': 'Título Público', 'quantidade': 15, 'valor': 750},
    {'nome': 'Poupança Ouro', 'tipo': 'Poupança', 'quantidade': 10, 'valor': 1000.00},
    {'nome': 'Poupança Viagens', 'tipo': 'Poupança', 'quantidade': 15, 'valor': 800.00},
  ];

  List<String> tiposAtivos = ['Ação', 'Fundo Imobiliário', 'Criptomoeda', 'Título Público', 'Poupança'];

  // Retorna o total de valor da carteira (valor total dos ativos)
  double get totalValor {
    double total = 0.0;
    for (var ativo in ativos) {
      total += ativo['valor'];
      //total += ativo['quantidade'] * ativo['valor']; => usar esse qdo for api, pq vai multiplicar pela qtd.
    }
    return total;
  }

  // Método para adicionar um ativo à lista
  void adicionarAtivo(String nome, String tipo, int quantidade, double valor) {
    // Validação dos dados antes de adicionar
    if (nome.isEmpty || tipo.isEmpty || quantidade <= 0 || valor <= 0) {
      throw ArgumentError('Os dados do ativo são inválidos.');
    }

    ativos.add({
      'nome': nome,
      'tipo': tipo,
      'quantidade': quantidade,
      'valor': valor,
    });
    
    notifyListeners();
  }

  void excluirAtivo(int index) {
    if (index >= 0 && index < ativos.length) {
      ativos.removeAt(index);
      notifyListeners();
    }
  }

  // Método para calcular as porcentagens de cada tipo de ativo
  Map<String, double> calcularPorcentagens() {
    double total = totalValor; // Total de valor da carteira
    if (total == 0) return {}; // Evitar divisão por zero

    Map<String, double> totalPorTipo = {
      'Ação': 0.0,
      'Fundo Imobiliário': 0.0,
      'Criptomoeda': 0.0,
      'Título Público': 0.0,
      'Poupança': 0.0,
    };

    // Para cada ativo, calculamos o valor e somamos à porcentagem do tipo correspondente
    for (var ativo in ativos) {
      double valorAtivo = ativo['valor'];
      //double valorAtivo = ativo['quantidade'] * ativo['valor']; => usar esse qdo for api, pq vai multiplicar pela qtd.
      totalPorTipo[ativo['tipo']] = totalPorTipo[ativo['tipo']]! + valorAtivo;
    }

    // Calcula a porcentagem de cada tipo
    Map<String, double> porcentagens = {};
    for (var tipo in totalPorTipo.keys) {
      porcentagens[tipo] = (totalPorTipo[tipo]! / total) * 100;
    }

    return porcentagens;
  }

  // Método para agrupar os ativos por tipo
  Map<String, List<Map<String, dynamic>>> agruparAtivosPorTipo() {
    Map<String, List<Map<String, dynamic>>> ativosPorTipo = {};

    for (var ativo in ativos) {
      if (!ativosPorTipo.containsKey(ativo['tipo'])) {
        ativosPorTipo[ativo['tipo']] = [];
      }
      ativosPorTipo[ativo['tipo']]!.add(ativo);
    }

    return ativosPorTipo;
  }

  // Método para calcular o percentual de cada ativo na carteira
  double calcularPercentual(int index) {
    double total = totalValor;
    if (total == 0) return 0;
    double valorAtivo = ativos[index]['valor'];
    //double valorAtivo = ativos[index]['quantidade'] * ativos[index]['valor']; => usar esse qdo for api, pq vai multiplicar pela qtd.
    return (valorAtivo / total) * 100;
  }
}
