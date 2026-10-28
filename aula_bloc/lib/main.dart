import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import 'produto_repository.dart';

void main() => runApp(const MaterialApp(home: TesteApiPage()));

class TesteApiPage extends StatefulWidget {
  const TesteApiPage({super.key});

  @override
  State<TesteApiPage> createState() => _TesteApiPageState();
}

class _TesteApiPageState extends State<TesteApiPage> {
  // 10.0.2.2 = host visto pelo emulador Android; nas outras plataformas, localhost
  final repository = ProdutoRepository(
    !kIsWeb && Platform.isAndroid
        ? 'http://10.0.2.2:5000'
        : 'http://localhost:5000',
  );
  String resultado = 'Aguardando consulta...';

  Future<void> consultarProdutos() async {
    setState(() => resultado = 'Consultando API...');

    String texto;
    try {
      final produtos = await repository.listarProdutos();
      texto = produtos
          .map((p) =>
              '${p.nome} (${p.categoria}): R\$ ${p.preco.toStringAsFixed(2)}')
          .join('\n');
    } catch (erro) {
      texto = 'Erro ao consultar API: $erro';
    }

    if (mounted) setState(() => resultado = texto);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Teste da API')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(resultado, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: consultarProdutos,
              child: const Text('Consultar Produtos'),
            ),
          ],
        ),
      ),
    );
  }
}
