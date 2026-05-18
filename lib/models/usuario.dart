class Usuario {
  final int? id;
  final String nome;
  final String? foto;
  final DateTime dataNascimento;
  final DateTime? createdAt;

  Usuario({
    this.id,
    required this.nome,
    this.foto,
    required this.dataNascimento,
    this.createdAt,
  });

  // função para calcular a idade:
  int get idade {
    final hoje = DateTime.now();
    int idade = hoje.year - dataNascimento.year;

    if (hoje.month < dataNascimento.month ||
        (hoje.month == dataNascimento.month && hoje.day < dataNascimento.day)) {
      idade--;
    }

    return idade;
  }

// função para transformar o objeto Usuario em um Mapa de dados (estrutura chave-valor) para salva no banco de dados:
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'foto': foto,
      'data_nascimento': dataNascimento.toIso8601String(),
    };
  }

// função para transformar o mapra de dados em objeto Usuario
  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'],
      nome: map['nome'],
      foto: map['foto'],
      dataNascimento: DateTime.parse(map['data_nascimento']),
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
    );
  }
}