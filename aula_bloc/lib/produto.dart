class Produto {
  final int id;
  final String nome;
  final double preco;
  final String categoria;

  const Produto({
    required this.id,
    required this.nome,
    required this.preco,
    required this.categoria,
  });

  factory Produto.fromJson(Map<String, dynamic> json) => Produto(
        id: (json['id'] as num).toInt(),
        nome: json['nome'] as String,
        preco: (json['preco'] as num).toDouble(),
        categoria: json['categoria'] as String,
      );
}
