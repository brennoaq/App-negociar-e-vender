import 'dart:io';
import 'dart:math';
import 'package:negociar_e_vender/values.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "simulacao.db";
  static final _databaseVersion = 1;

  static final table = 'ramos';
  static final tableTaxas = 'taxas';
  static final tablePropostas = 'propostas';

  static final columnId = 'id';
  static final columnName = 'name';
  static final columnCPF = 'cpf';
  static final columnEmail = 'email';
  static final columnPhone = 'phone';
  static final columnTimestamp = 'timestamp';
  static final columnConcorrente = 'concorrente';
  static final columnTaxaConcorrenteDebito = 'taxa_concorrente_debito';
  static final columnTaxaConcorrenteCredito = 'taxa_concorrente_credito';
  static final columnDescontoDebito = 'desconto_debito';
  static final columnDescontoCredito = 'desconto_credito';
  static final columnTaxaFinalDebito = 'taxa_final_debito';
  static final columnTaxaFinalCredito = 'taxa_final_credito';

  static final columnRamo = 'ramo';
  static final columnDebito = 'debito';
  static final columnCredito = 'credito';
  static final columnMinDebito = 'minDebito';
  static final columnMinCredito = 'minCredito';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName VARCHAR(255) NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE $tableTaxas (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName VARCHAR(255) NOT NULL,
            $columnRamo VARCHAR(255) NOT NULL,
            $columnDebito REAL NOT NULL,
            $columnCredito REAL NOT NULL,
            $columnMinCredito REAL NOT NULL,
            $columnMinDebito REAL NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE $tablePropostas (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnCPF VARCHAR(255) NOT NULL,
            $columnEmail VARCHAR(255),
            $columnPhone VARCHAR(255) NOT NULL,
            $columnRamo VARCHAR(255) NOT NULL,
            $columnTimestamp VARCHAR(255) NOT NULL,
            $columnConcorrente VARCHAR(255) NOT NULL,
            $columnTaxaConcorrenteDebito REAL NOT NULL,
            $columnTaxaConcorrenteCredito REAL NOT NULL,
            $columnDescontoDebito REAL NOT NULL,
            $columnDescontoCredito REAL NOT NULL,
            $columnTaxaFinalDebito REAL NOT NULL,
            $columnTaxaFinalCredito REAL NOT NULL
          )
          ''');

    await _populateRamos(db);
    await _populateTaxas(db);
  }

  Future<int> insert(String table, Map<String, dynamic> row,
      {Database db}) async {
    if (db == null) {
      db = await instance.database;
    }
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    Database db = await instance.database;
    return await db.query(table);
  }

  _populateRamos(Database db) async {
    for (final i in ramos_atividade) {
      await insert(
          table,
          {
            'name': i,
          },
          db: db);
    }
  }

  _populateTaxas(Database db) async {
    for (final i in concorrentes) {
      for (final u in ramos_atividade) {
        final random = Random();
        final credito = 2.8 + random.nextDouble() * 0.5;
        final debito = 1.8 + random.nextDouble() * 0.5;
        final minCredito = credito - random.nextDouble();
        final minDebito = debito - random.nextDouble();
        await insert(
            tableTaxas,
            {
              'name': i,
              'ramo': u,
              'credito': credito,
              'debito': debito,
              'minCredito': minCredito,
              'minDebito': minDebito
            },
            db: db);
      }
    }
  }

  Future deleteDatabaseByPath() async {
    _database?.close();
    _database = null;
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    await deleteDatabase(path);
  }
}
