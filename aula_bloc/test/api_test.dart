// Teste de integração: precisa da API Flask rodando em localhost:5000
// (ou desligada, passando --dart-define=API_DESLIGADA=true).
import 'dart:io';

import 'package:aula_bloc/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const apiDesligada = bool.fromEnvironment('API_DESLIGADA');

void main() {
  // flutter_test bloqueia HTTP real por padrão; libera para falar com o Flask
  setUpAll(() => HttpOverrides.global = null);

  testWidgets('botão Consultar Produtos mostra o resultado da API',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: TesteApiPage()));
    expect(find.text('Aguardando consulta...'), findsOneWidget);

    // a requisição precisa nascer fora do relógio falso do teste
    await tester.runAsync(() async {
      await tester.tap(find.text('Consultar Produtos'));
      // espera até sair do "Consultando API..." (timeout do repository é 5 s)
      for (var i = 0; i < 70; i++) {
        await Future.delayed(const Duration(milliseconds: 100));
        await tester.pump();
        if (find.text('Consultando API...').evaluate().isEmpty) break;
      }
    });
    await tester.pump();

    final texto = tester
        .widgetList<Text>(find.byType(Text))
        .first
        .data!;
    // ignore: avoid_print
    print('Tela mostrou:\n$texto');

    if (apiDesligada) {
      expect(texto, startsWith('Erro ao consultar API:'));
    } else {
      expect(texto, contains('Mouse (Periféricos): R\$ 59.90'));
      expect(texto, contains('Webcam (Vídeo): R\$ 189.90'));
    }
  });
}
