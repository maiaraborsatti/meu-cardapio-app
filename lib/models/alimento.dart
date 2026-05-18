class Alimento {
  final int? id;
  final String nome;
  final String? foto;
  final String categoria; // café, almoço, janta
  final String tipo; // bebida, proteína, carboidrato, fruta, grão
  final DateTime? createdAt;

  Alimento({
    this.id,
    required this.nome,
    this.foto,
    required this.categoria,
    required this.tipo,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'foto': foto,
      'categoria': categoria,
      'tipo': tipo,
    };
  }

  factory Alimento.fromMap(Map<String, dynamic> map) {
    return Alimento(
      id: map['id'],
      nome: map['nome'],
      foto: map['foto'],
      categoria: map['categoria'],
      tipo: map['tipo'],
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
    );
  }
}