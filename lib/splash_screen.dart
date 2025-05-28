import 'package:flutter/material.dart';
import 'dart:async';

/// Tela de splash que exibe a logo com animação de entrada e saída
/// antes de navegar para a próxima tela
class SplashScreen extends StatefulWidget {
  /// Widget para o qual a aplicação deve navegar após a animação de splash
  final Widget nextScreen;

  /// Construtor da SplashScreen
  /// @param key - Chave do widget
  /// @param nextScreen - Tela que será exibida após o splash
  const SplashScreen({super.key, required this.nextScreen});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

/// Estado da tela de splash que gerencia as animações
/// SingleTickerProviderStateMixin é usado para fornecer um ticker
/// que é necessário para as animações
class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  /// Controlador para gerenciar a animação
  late AnimationController _controller;

  /// Animação para controlar a opacidade (transparência) da logo
  late Animation<double> _opacityAnimation;

  /// Animação para controlar o tamanho (escala) da logo
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Inicializa o controlador de animação com duração de 1 segundo
    _controller = AnimationController(
      vsync: this, // O ticker provider
      duration: const Duration(milliseconds: 2000), // Duração da animação
    );

    // Configura a animação de opacidade:
    // - Começa invisível (0.0)
    // - Termina totalmente visível (1.0)
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        // Na primeira metade da animação, aplica uma curva de entrada
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
        // Na reversão (saída), aplica uma curva de saída na segunda metade
        reverseCurve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    // Configura a animação de escala:
    // - Começa com metade do tamanho (0.5)
    // - Termina com tamanho normal (1.0)
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        // Usa curva de aceleração para entrada
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        // Usa curva de desaceleração para saída
        reverseCurve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    // Inicia a animação de entrada (forward)
    _controller.forward();

    // Configura um timer para iniciar a animação de saída após 2 segundos
    Timer(const Duration(milliseconds: 2000), () {
      // Quando o timer terminar, reverte a animação (fade out e scale down)
      _controller.reverse().then((_) {
        // Após a animação de saída terminar completamente, navega para a próxima tela
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            // Define qual página será exibida
            pageBuilder: (context, animation, secondaryAnimation) =>
                widget.nextScreen,
            // Define a transição entre as telas (fade)
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
            // Define o tempo da transição entre as telas
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    // Libera os recursos do controlador de animação quando
    // o widget for removido da árvore de widgets
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Cria a estrutura visual da tela de splash
    return Scaffold(
      // Define o fundo como branco
      backgroundColor: Colors.white,
      // SafeArea garante que o conteúdo fique dentro da área visível
      // e não seja coberto por notches ou barras de sistema
      body: SafeArea(
        // Centraliza o conteúdo na tela
        child: Center(
          // AnimatedBuilder reconstrói seu filho sempre que a animação muda
          child: AnimatedBuilder(
            // A animação que será observada
            animation: _controller,
            // Função que constrói o widget com base no estado atual da animação
            builder: (context, child) {
              return Opacity(
                // Aplica o valor atual da animação de opacidade
                opacity: _opacityAnimation.value,
                child: Transform.scale(
                  // Aplica o valor atual da animação de escala
                  scale: _scaleAnimation.value,
                  // Adiciona um padding ao redor da imagem
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    // Carrega e exibe a imagem da logo
                    child: Image.asset('assets/logo.png', fit: BoxFit.contain),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
