import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get_it/get_it.dart';
import '../controller/extrato_controller.dart';

class ExtratoView extends StatefulWidget {
  const ExtratoView({super.key});

  @override
  State<ExtratoView> createState() => _ExtratoViewState();
}

class _ExtratoViewState extends State<ExtratoView> {
  late ExtratoController controller;
  late int anoSelecionado;

  @override
  void initState() {
    super.initState();
    // Pega a instância do ExtratoController via GetIt
    controller = GetIt.instance<ExtratoController>();
    anoSelecionado = controller.obterAnosDisponiveis().last;
  }

  @override
  Widget build(BuildContext context) {
    // Calculando o total de proventos do ano selecionado
    double totalProventos = controller.obterProventosPorAno(anoSelecionado)
        .fold(0.0, (sum, item) => sum + item['provento']);

    return Scaffold(
      backgroundColor: Colors.green.shade900, 
      appBar: AppBar(
        title: const Text('Extrato de Proventos', style: TextStyle(color: Color(0xFFEDE5B2))),
        backgroundColor: Colors.grey.shade900,
        iconTheme: const IconThemeData(color: Color(0xFFEDE5B2)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0), // Ajuste de padding para melhorar o espaçamento
        child: Column(
          children: [
            // Seletor de ano (agora inclui 2023, 2024, e 2025)
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFEDE5B2), 
                borderRadius: BorderRadius.circular(8), 
              ),
              width: 90.0, 
              height: 50.0, 
              child: DropdownButton<int>(
                value: anoSelecionado,
                onChanged: (int? novoAno) {
                  setState(() {
                    anoSelecionado = novoAno!;
                  });
                },
                items: controller.obterAnosDisponiveis().map<DropdownMenuItem<int>>((int ano) {
                  return DropdownMenuItem<int>(
                    value: ano,
                    child: Center( // Alinha o texto ao centro
                      child: Text(
                        ano.toString(),
                        style: const TextStyle(fontSize: 18, color: Color(0xFF212121)), 
                      ),
                    ),
                  );
                }).toList(),
                dropdownColor: const Color(0xFFEDE5B2), 
                style: const TextStyle(color: Color(0xFF212121)), 
                isExpanded: true, 
              ),
            ),

            const SizedBox(height: 24),

            // Exibição dos proventos mensais (usando os dados do ano selecionado)
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 3 colunas
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.5,
                ),
                itemCount: 12, // Meses do ano
                itemBuilder: (context, index) {
                  DateTime data = DateTime(anoSelecionado, index + 1, 1);
                  String mes = DateFormat.MMMM('pt_BR').format(data); // Nome completo do mês
                  String mesComPrimeiraMaiuscula = mes[0].toUpperCase() + mes.substring(1); // Primeira letra maiúscula

                  return Card(
                    color: const Color(0xFFEDE5B2), 
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          mesComPrimeiraMaiuscula, 
                          style: const TextStyle(
                            color: Color(0xFF212121), 
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          controller.obterProventoFormatado(data),
                          style: const TextStyle(
                            color: Color(0xFF212121), 
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            //const SizedBox(height: 14), // Espaço entre a grid e o total de proventos

            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF7DEB7E), 
                borderRadius: BorderRadius.circular(10), 
              ),
              padding: const EdgeInsets.all(10),
              width: 230.0,// double.infinity, para ocupar toda a largura
              height: 95.0,
              margin: const EdgeInsets.only(bottom: 160.0), // afasta do fim da tela
              child: Column(
                children: [
                  const Text(
                    'Total de Proventos',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Color(0xFF212121), 
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'R\$ ${totalProventos.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 22,
                      color: Color(0xFF212121), 
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
