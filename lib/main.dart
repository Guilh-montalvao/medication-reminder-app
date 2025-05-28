import 'package:flutter/material.dart';
import 'splash_screen.dart';

/// Ponto de entrada principal da aplicação
void main() {
  runApp(const MyApp());
}

/// Widget raiz da aplicação que configura o tema e a página inicial
class MyApp extends StatelessWidget {
  /// Construtor do aplicativo principal
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Título da aplicação que aparece na barra de tarefas/multitarefa
      title: 'Drogaria São Rafael',
      // Remove o banner de debug no canto superior direito
      debugShowCheckedModeBanner: false,
      // Configuração do tema da aplicação
      theme: ThemeData(
        // Define o esquema de cores com base na cor verde da Drogaria São Rafael
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00562B), // Cor base para gerar o esquema
          primary: const Color(0xFF00562B), // Cor primária (verde)
        ),
        // Habilita o Material Design 3
        useMaterial3: true,
      ),
      // Define a tela inicial como a SplashScreen, que posteriormente
      // navegará para a HomePage quando a animação terminar
      home: SplashScreen(nextScreen: const HomePage()),
    );
  }
}

/// Tela principal que será exibida após a animação de splash
class HomePage extends StatefulWidget {
  /// Construtor da tela principal
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

/// Estado da tela principal que gerencia a UI
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior do aplicativo
      appBar: AppBar(
        // Define a cor de fundo da AppBar como verde
        backgroundColor: const Color(0xFF00562B),
        // Título na barra de aplicativo
        title: const Text(
          'Drogaria São Rafael',
          // Estilo do texto: branco e negrito
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      // Corpo principal da tela
      body: Center(
        // Organiza os elementos em uma coluna vertical
        child: Column(
          // Centraliza os elementos na vertical
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Texto de boas-vindas
            const Text(
              'Bem-vindo à Drogaria São Rafael',
              // Estilo do texto: tamanho 20, negrito e verde
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00562B), // Verde da marca
              ),
            ),
            // Espaçamento vertical de 20 pixels
            const SizedBox(height: 20),
            // Exibe a logo da drogaria
            Image.asset('assets/logo.png', width: 200, height: 200),
          ],
        ),
      ),
    );
  }
}
