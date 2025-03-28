import 'package:flutter/material.dart';
import '../view/ativos_view.dart';
import '../view/analises_view.dart';
import '../view/resumo_view.dart';
import '../view/extrato_view.dart';

class OpcoesController {
  void navegarPara(BuildContext context, String rota) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        if (rota == 'analises') {
          return AnalisesView();
        } else if (rota == 'ativos') {
          return AtivosView();
        } else if (rota == 'resumo') {
          return ResumoView();
        } else if (rota == 'extrato') {
          return ExtratoView();
        } else {
          return Container(); // Adicione outras telas aqui se necessário
        }
      }),
    );
  }
}
