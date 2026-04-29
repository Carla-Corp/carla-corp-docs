import 'dart:math';
import 'package:flutter/material.dart';

class SimpleTyping extends StatefulWidget {
  final List<String> sentences;
  final Duration tempoEntreLetras;
  final Duration tempoEntreFrases;
  final TextStyle style;
  final double chanceErro;
  final bool restart;
  final VoidCallback? then;
  const SimpleTyping({
    Key? key,
    required this.sentences,
    required this.style,
    required this.restart,
    this.tempoEntreLetras = const Duration(milliseconds: 30),
    this.tempoEntreFrases = const Duration(seconds: 2),
    this.chanceErro = 0.01,
    this.then,
  }) : super(key: key);

  @override
  State<SimpleTyping> createState() => _SimpleTypingState();
}

class _SimpleTypingState extends State<SimpleTyping> {
  String text = '';
  int index = 0;
  final Random random = Random();
  bool _running = true; // 🔥 controla o loop

  @override
  void initState() {
    super.initState();
    _comecarDigitacao();
  }

  @override
  void dispose() {
    _running = false; // 🔥 para o loop
    super.dispose();
  }

  void _comecarDigitacao() async {
    while (_running) {
      String frase = widget.sentences[index];

      for (int i = 0; i <= frase.length && _running; i++) {
        if (!mounted) return;

        setState(() {
          text = frase.substring(0, i);
        });

        await Future.delayed(widget.tempoEntreLetras);

        if (!_running) return;

        if (i > 0 && i < frase.length && random.nextDouble() < widget.chanceErro) {
          String errado = _gerarCaractereErrado(frase[i]);

          if (!mounted) return;
          setState(() {
            text = frase.substring(0, i) + errado;
          });

          await Future.delayed(widget.tempoEntreLetras * 2);

          for (int j = 0; j <= errado.length && _running; j++) {
            if (!mounted) return;

            setState(() {
              text = frase.substring(0, i) +
                  (j < errado.length ? errado.substring(0, errado.length - j) : '');
            });

            await Future.delayed(widget.tempoEntreLetras);
          }

          i--;
        }
      }

      if (!widget.restart || !_running) break;

      await Future.delayed(widget.tempoEntreFrases);

      if (!mounted) return;

      setState(() {
        text = '';
        index = (index + 1) % widget.sentences.length;
      });
    }

    if (_running) {
      widget.then?.call();
    }
  }

  String _gerarCaractereErrado(String letraCerta) {
    String letters =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%&*';
    String wrong;
    do {
      wrong = letters[random.nextInt(letters.length)];
    } while (wrong == letraCerta);
    return wrong;
  }

  @override
  Widget build(BuildContext context) {
    return Text(text, style: widget.style);
  }
}