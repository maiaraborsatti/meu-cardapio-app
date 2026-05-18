import '../../models/usuario.dart';
import '../database.dart';

class UsuarioRepository {
  // Pega a instância do banco de dados
  final _dbHelper = DatabaseHelper.instance;

  Future<int> cadastrarUsuario(Usuario usuario) async {
    final db = await _dbHelper.database;
    return await db.insert('usuarios', usuario.toMap());
  }

  Future<List<Usuario>> buscarUsuariosPorNome(String nome) async {
    final db = await _dbHelper.database;
    final resultado = await db.query(
      'usuarios',
      where: 'nome LIKE ?',
      whereArgs: ['%$nome%'],
    );
    return resultado.map((map) => Usuario.fromMap(map)).toList();
  }

  Future<List<Usuario>> listarTodosUsuarios() async {
    final db = await _dbHelper.database;
    final resultado = await db.query('usuarios', orderBy: 'nome ASC');
    return resultado.map((map) => Usuario.fromMap(map)).toList();
  }

  Future<Usuario?> buscarUsuarioPorId(int id) async {
    final db = await _dbHelper.database;
    final resultado = await db.query('usuarios', where: 'id = ?', whereArgs: [id]);
    if (resultado.isNotEmpty) return Usuario.fromMap(resultado.first);
    return null;
  }

  Future<int> atualizarUsuario(Usuario usuario) async {
    final db = await _dbHelper.database;

    return await db.update(
      'usuarios',
     usuario.toMap(),
      where: 'id = ?',
      whereArgs: [usuario.id],
    );
  }

  Future<int> deletarUsuario(int id) async {
    final db = await _dbHelper.database;

    return await db.delete(
      'usuarios',
      where: 'id = ?',
     whereArgs: [id],
    );
  }

}