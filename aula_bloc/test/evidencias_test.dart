// Gera os prints da tela em ../evidencias, com a API Flask rodando em localhost:5000
// (ou desligada, passando --dart-define=API_DESLIGADA=true).
import 'dart:io';
import 'dart:ui' as ui;

import 'package:aula_bloc/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

const apiDesligada = bool.fromEnvironment('API_DESLIGADA');

// os testes usam uma fonte de quadradinhos; carrega a Roboto do SDK para o print ficar legível
Future<void> carregarRoboto() async {
  final pasta = '${Platform.environment['FLUTTER_ROOT'] ?? r'C:\flutter'}'
      r'\bin\cache\artifacts\material_fonts';
  final loader = FontLoader('Roboto');
  for (final arquivo in ['roboto-regular.ttf', 'roboto-medium.ttf']) {
    final bytes = File('$pasta\\$arquivo').readAsBytesSync();
    loader.addFont(Future.value(ByteData.sublistView(bytes)));
  }
  await loader.load();
}

Future<void> salvarPrint(WidgetTester tester, String nome) async {
  await tester.runAsync(() async {
    final boundary = tester.renderObject<RenderRepaintBoundary>(
        find.byKey(const Key('tela')));
    final imagem = await boundary.toImage(pixelRatio: 2);
    final png = await imagem.toByteData(format: ui.ImageByteFormat.png);
    File('../evidencias/$nome.png')
      ..createSync(recursive: true)
      ..writeAsBytesSync(png!.buffer.asUint8List());
  });
}

void main() {
  setUpAll(() => HttpOverrides.global = null);

  testWidgets('gera print da consulta', (tester) async {
    await tester.runAsync(carregarRoboto);
    tester.view.physicalSize = const Size(720, 1280);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const RepaintBoundary(
      key: Key('tela'),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TesteApiPage(),
      ),
    ));

    await tester.runAsync(() async {
      await tester.tap(find.text('Consultar Produtos'));
      for (var i = 0; i < 70; i++) {
        await Future.delayed(const Duration(milliseconds: 100));
        await tester.pump();
        if (find.text('Consultando API...').evaluate().isEmpty) break;
      }
    });
    await tester.pumpAndSettle();

    await salvarPrint(tester, apiDesligada ? 'app_erro' : 'app_sucesso');
  });
}
