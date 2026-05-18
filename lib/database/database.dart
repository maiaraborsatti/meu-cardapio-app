import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // garante uma única instância do banco ativa
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('meu_cardapio.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // criação das tabelas
  Future _createDB(Database db, int version) async {
    // 1. Tabela de Usuários
    await db.execute('''
      CREATE TABLE usuarios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        foto TEXT,
        data_nascimento TEXT NOT NULL,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // 2. Tabela de Alimentos
    await db.execute('''
      CREATE TABLE alimentos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        foto TEXT,
        categoria TEXT NOT NULL,
        tipo TEXT NOT NULL,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // 3. Tabela de Cardápios
    await db.execute('''
      CREATE TABLE cardapios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        usuario_id INTEGER NOT NULL,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (usuario_id) REFERENCES usuarios (id) ON DELETE CASCADE
      )
    ''');

    // 4. Tabela Intermediária: Itens do Cardápio
    await db.execute('''
      CREATE TABLE cardapio_items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        cardapio_id INTEGER NOT NULL,
        alimento_id INTEGER NOT NULL,
        refeicao TEXT NOT NULL,
        FOREIGN KEY (cardapio_id) REFERENCES cardapios (id) ON DELETE CASCADE,
        FOREIGN KEY (alimento_id) REFERENCES alimentos (id) ON DELETE CASCADE
      )
    ''');
  }

  // Fechar o banco se necessário
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}