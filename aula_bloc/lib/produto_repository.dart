import 'dart:convert';

import 'package:http/http.dart' as http;

import 'produto.dart';

class ProdutoRepository {
  final String baseUrl;

  const ProdutoRepository(this.baseUrl);

  Future<List<Produto>> listarProdutos() async {
    final resposta = await http
        .get(Uri.parse('$baseUrl/produtos'))
        .timeout(const Duration(seconds: 5));

    if (resposta.statusCode != 200) {
      throw Exception('Erro HTTP: ${resposta.statusCode}');
    }

    final List<dynamic> dados = jsonDecode(utf8.decode(resposta.bodyBytes));
    return dados.map((item) => Produto.fromJson(item)).toList();
  }
}
