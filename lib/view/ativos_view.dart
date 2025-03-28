import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../controller/ativos_controller.dart';

final g = GetIt.instance; 

class AtivosView extends StatefulWidget {
  const AtivosView({super.key});

  @override
  _AtivosViewState createState() => _AtivosViewState();
}

class _AtivosViewState extends State<AtivosView> {
  // Variável para armazenar o tipo de ativo selecionado
  String tipoSelecionado = 'Ação';

  @override
  Widget build(BuildContext context) {
    final ativosController = g<AtivosController>();
    final ativosPorTipo = ativosController.agruparAtivosPorTipo();

    return Scaffold(
      appBar: AppBar(
        title: Text('Ativos', style: TextStyle(color: Color(0xFFEDE5B2))),
        backgroundColor: Colors.grey.shade900,
        iconTheme: IconThemeData(color: Color(0xFFEDE5B2)),
      ),
      body: Container(
        color: Colors.green.shade900, 
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                _showAtivoDialog(context, ativosController);
              },
              child: Text('Adicionar Ativo'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFEDE5B2), 
                foregroundColor: Colors.grey.shade900, 
                textStyle: TextStyle(fontSize: 16), 
              ),
            ),
            
            SizedBox(height: 15), 
            
            Expanded(
              child: ListView(
                children: ativosPorTipo.keys.map((tipo) {
                  final ativos = ativosPorTipo[tipo]!;

                  return Card(
                    color: Color(0xFFEDE5B2), 
                    margin: EdgeInsets.only(bottom: 30),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tipo,
                            style: TextStyle(
                              color: Colors.grey.shade900, 
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Divider(
                            color: Colors.grey.shade900, 
                            height: 20,
                          ),
                          for (var ativo in ativos)
                            _buildAtivoItem(ativo, ativosController),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAtivoItem(Map<String, dynamic> ativo, AtivosController ativosController) {
    int index = ativosController.ativos.indexOf(ativo);
    double percentual = ativosController.calcularPercentual(index);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        color: Color(0xFF7DEB7E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: Color(0xFFEDE5B2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ativo['nome'],
                        style: TextStyle(color: Colors.green.shade900, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text('Quantidade: ${ativo['quantidade']}', style: TextStyle(color: Colors.grey.shade900)),
                      Text('Valor: R\$ ${ativo['valor'].toStringAsFixed(2)}', style: TextStyle(color: Colors.grey.shade900)),
                      Text('Rentabilidade: 0%', style: TextStyle(color: Colors.grey.shade900)),
                      Text('Porcentagem na carteira: ${percentual.toStringAsFixed(2)}%', style: TextStyle(color: Colors.grey.shade900)),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.grey.shade900),
                  onPressed: () {
                    setState(() {
                      ativosController.excluirAtivo(index);
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAtivoDialog(BuildContext context, AtivosController ativosController) {
    final nomeController = TextEditingController();
    final quantidadeController = TextEditingController();
    final valorController = TextEditingController();

    List<String> tiposAtivos = ['Ação', 'Fundo Imobiliário', 'Criptomoeda', 'Título Público', 'Poupança'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade900,
          title: Text('Novo Ativo', style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome do Ativo', 
                  labelStyle: TextStyle(color: Color(0xFFEDE5B2)),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 10), 
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFEDE5B2), 
                  borderRadius: BorderRadius.circular(8), 
                ),
                child: StatefulBuilder(
                  builder: (context, setStateDialog) {
                    return DropdownButton<String>(
                      value: tipoSelecionado, 
                      onChanged: (String? newValue) {
                        setStateDialog(() {
                          tipoSelecionado = newValue!;
                        });
                      },
                      items: tiposAtivos.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: TextStyle(color: Colors.grey.shade900)),
                        );
                      }).toList(),
                      elevation: 10,
                      style: TextStyle(color: Colors.black),
                      dropdownColor: Color(0xFFEDE5B2),
                      iconEnabledColor: Colors.black,
                    );
                  },
                ),
              ),
              SizedBox(height: 10), 
              TextField(
                controller: quantidadeController,
                decoration: InputDecoration(labelText: 'Quantidade', labelStyle: TextStyle(color: Color(0xFFEDE5B2))),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 10), 
              TextField(
                controller: valorController,
                decoration: InputDecoration(labelText: 'Valor', labelStyle: TextStyle(color: Color(0xFFEDE5B2))),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                String nome = nomeController.text;
                String tipo = tipoSelecionado;
                int quantidade = int.parse(quantidadeController.text);
                double valor = double.parse(valorController.text);

                setState(() {
                  ativosController.adicionarAtivo(nome, tipo, quantidade, valor);
                });
                Navigator.pop(context);
              },
              child: Text('Adicionar', style: TextStyle(color: Colors.grey.shade900)),
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFFEDE5B2),
                textStyle: TextStyle(fontSize: 12),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar', style: TextStyle(color: Colors.grey.shade900)),
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFFEDE5B2),
                textStyle: TextStyle(fontSize: 12),
              ),
            ),
          ],
        );
      },
    );
  }
}
