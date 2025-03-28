import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
  
import 'controller/cadastro_controller.dart';
import 'controller/esqueceu_controller.dart';
import 'controller/sobre_controller.dart';
import 'controller/ativos_controller.dart';  
import 'controller/resumo_controller.dart';  
import 'controller/extrato_controller.dart';  
import 'controller/analises_controller.dart';  
import 'view/cadastro_view.dart';
import 'view/exibicao_view.dart';
import 'view/home_view.dart';
import 'view/esqueceu_view.dart';
import 'view/sobre_view.dart';
import 'view/opcoes_view.dart';
import 'view/ativos_view.dart'; 
import 'view/resumo_view.dart'; 
import 'view/extrato_view.dart';
import 'view/analises_view.dart';

final g = GetIt.instance;

void setupLocator() {
  // Registrando os controladores no GetIt
  g.registerSingleton<CadastroController>(CadastroController());
  g.registerSingleton<EsqueceuController>(EsqueceuController());
  g.registerSingleton<SobreController>(SobreController());
  g.registerLazySingleton<AtivosController>(() => AtivosController());
  g.registerSingleton<ExtratoController>(ExtratoController());
  g.registerSingleton<AnalisesController>(AnalisesController());
}

void main() {
  setupLocator();  // Configura o GetIt
  runApp(
    DevicePreview(
      builder: (context) => MultiProvider( // Usando MultiProvider para fornecer múltiplos controllers
        providers: [
          ChangeNotifierProvider(create: (context) => AtivosController()), 
          Provider(create: (context) => ResumoController()), 
        ],
        child: const MainApp(),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navegação',
      theme: ThemeData( // aqui aplica em todas as telas para não ter que ficar fazendo em cada uma (é para quando não preencher um campo a notificação vir em texto / borda do campo branco)
        inputDecorationTheme: InputDecorationTheme(
          errorStyle: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
        ),
      ),
      initialRoute: 'home',
      routes: {
        'home': (context) => const HomeView(),
        'cadastro': (context) => const CadastroView(),
        'exibicao': (context) => const ExibicaoView(),
        'esqueceu_senha': (context) => const EsqueceuView(),
        'sobre': (context) => SobreView(),
        'opcoes': (context) => const OpcoesView(),
        'ativos': (context) => const AtivosView(), 
        'resumo': (context) => const ResumoView(), 
        'extrato': (context) => const ExtratoView(),
        'analises': (context) => AnalisesView(),
      },
    );
  }
}
