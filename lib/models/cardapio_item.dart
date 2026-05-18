class CardapioItem {
  final int? id;
  final int cardapioId;
  final int alimentoId;
  final String refeicao; // café, almoço, janta

  CardapioItem({
    this.id,
    required this.cardapioId,
    required this.alimentoId,
    required this.refeicao,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cardapio_id': cardapioId,
      'alimento_id': alimentoId,
      'refeicao': refeicao,
    };
  }

  factory CardapioItem.fromMap(Map<String, dynamic> map) {
    return CardapioItem(
      id: map['id'],
      cardapioId: map['cardapio_id'],
      alimentoId: map['alimento_id'],
      refeicao: map['refeicao'],
    );
  }
}