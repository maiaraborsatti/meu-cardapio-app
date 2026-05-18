class Cardapio {
  final int? id;
  final int usuarioId;
  final DateTime? createdAt;

  Cardapio({
    this.id,
    required this.usuarioId,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'usuario_id': usuarioId,
    };
  }

  factory Cardapio.fromMap(Map<String, dynamic> map) {
    return Cardapio(
      id: map['id'],
      usuarioId: map['usuario_id'],
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
    );
  }
}