import '../../models/alimento.dart';
import '../database.dart';

class AlimentoRepository {
  final _dbHelper = DatabaseHelper.instance;

  Future<int> inserirAlimento(Alimento alimento) async {
    final db = await _dbHelper.database;
    return await db.insert('alimentos', alimento.toMap());
  }

  Future<List<Alimento>> buscarAlimentosPorNome(String nome) async {
    final db = await _dbHelper.database;
    final resultado = await db.query(
      'alimentos',
      where: 'nome LIKE ?',
      whereArgs: ['%$nome%'],
    );
    return resultado.map((map) => Alimento.fromMap(map)).toList();
  }

  Future<List<Alimento>> listarTodosAlimentos() async {
    final db = await _dbHelper.database;
    final resultado = await db.query('alimentos', orderBy: 'nome ASC');
    return resultado.map((map) => Alimento.fromMap(map)).toList();
  }

  Future<int> atualizarAlimento(Alimento alimento) async {
    final db = await _dbHelper.database;
    return await db.update(
      'alimentos',
      alimento.toMap(),
      where: 'id = ?',
      whereArgs: [alimento.id],
    );
  }

  Future<int> deletarAlimento(int id) async {
    final db = await _dbHelper.database;
    return await db.delete(
      'alimentos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}