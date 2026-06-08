import '../../models/cardapio.dart';
import '../../models/cardapio_item.dart';
import '../database.dart';

class CardapioRepository {
  final _dbHelper = DatabaseHelper.instance;

    //cria a lista de cardápios
    Future<List<Cardapio>> listarCardapiosPorUsuario(int usuarioId) async {

  final db = await _dbHelper.database;

  final resultado = await db.query(
    'cardapios',
    where: 'usuario_id = ?',
    whereArgs: [usuarioId],
    orderBy: 'id DESC', // mais recente primeiro
  );

  return resultado
      .map((e) => Cardapio.fromMap(e))
      .toList();
}

  // Cria o cabeçalho do cardápio vinculado ao usuário
  Future<int> criarCardapio(Cardapio cardapio) async {
    final db = await _dbHelper.database;
    return await db.insert('cardapios', cardapio.toMap());
  }

  // Adiciona um alimento específico a esse cardápio (ex: arroz no almoço)
  Future<int> adicionarItemAoCardapio(CardapioItem item) async {
    final db = await _dbHelper.database;
    return await db.insert('cardapio_items', item.toMap());
  }

  // Remove um alimento específico do cardápio
  Future<int> removerItemDoCardapio(int itemId) async {
    final db = await _dbHelper.database;
    return await db.delete(
      'cardapio_items',
      where: 'id = ?',
      whereArgs: [itemId],
    );
  }

  // Deleta o cardápio inteiro (ON DELETE CASCADE não aplicado)
  Future<int> deletarCardapio(int id) async {
    final db = await _dbHelper.database;
    return await db.delete(
      'cardapios',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // relatório completo do cardápio cruzando os dados com a tabela de alimentos
  Future<List<Map<String, dynamic>>> buscarCardapioCompletoDoUsuario(int usuarioId) async {
    final db = await _dbHelper.database;
    
    final resultado = await db.rawQuery('''
      SELECT 
        ci.id AS item_id,
        c.id AS cardapio_id, 
        ci.refeicao,
        a.nome AS alimento_nome,
        a.categoria AS alimento_categoria,
        a.tipo AS alimento_tipo,
        a.foto AS alimento_foto
      FROM cardapios c
      INNER JOIN cardapio_items ci ON c.id = ci.cardapio_id
      INNER JOIN alimentos a ON ci.alimento_id = a.id
      WHERE c.usuario_id = ?
    ''', [usuarioId]);

    return resultado;
  }

  Future<List<Map<String, dynamic>>> buscarCardapioPorId(int cardapioId) async {
  final db = await _dbHelper.database;

  final resultado = await db.rawQuery('''
    SELECT 
      ci.id AS item_id,
      c.id AS cardapio_id, 
      ci.refeicao,
      a.id AS alimento_id,
      a.nome AS alimento_nome,
      a.categoria AS alimento_categoria,
      a.tipo AS alimento_tipo,
      a.foto AS alimento_foto
    FROM cardapios c
    INNER JOIN cardapio_items ci ON c.id = ci.cardapio_id
    INNER JOIN alimentos a ON ci.alimento_id = a.id
    WHERE c.id = ?
  ''', [cardapioId]);

  return resultado;
}
}