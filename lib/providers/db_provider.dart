import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_reader/models/scan_model.dart';
export 'package:qr_reader/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {

  static Database? _database;
  static final DBProvider db = DBProvider._();

  //C:\Users\rlagosg\AppData\Local\Google\AndroidStudio2021.3\device-explorer\Pixel_4_XL_API_30 [emulator-5554]\data\user\0\com.example.qr_reader\app_flutter

  DBProvider._();

  Future<Database> get database async {
    if (_database != null)  return _database!;
    _database = await initDB();

    return _database!;
  }
  
  Future<Database> initDB() async{
    //Path de donde almacerameos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join( documentsDirectory.path, 'ScansDB.db');
    print(path);

    //crear base de datos
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version)async{
        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )
        ''');
      },
    );
  }

  //insertar un nuevo registro
  Future<int> nuevoScanRaw ( ScanModel nuevoScan) async{

    final id    = nuevoScan.id;
    final tipo  = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    //referencia a la base de datos
    final db =  await database;
    final res = await db.rawInsert('''
      INSERT INTO Scans( $id, '$tipo', '$valor')
        VALUES( )
    ''');

    return res;
  }

  //insertar un nuevo registro  
  Future<int> nuevoScan( ScanModel nuevoScan ) async {
    final db =  await database;
    final res = await db.insert('Scans', nuevoScan.toJson());
    //es el id  del ultimo registro insertado
    //print( res);
    return res;
  }

  //Obtener registros
  Future<ScanModel?> getScanById( int i ) async {

    final db = await database;
    //todas -> final res = await db.query('Scans');
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [i]);

    return res.isEmpty
      ? ScanModel.fromJson(res.first)
      : null;
  }

  //todos los registros
  Future<List<ScanModel>> getTodosLosScans() async {

    final db = await database;
    //todas -> final res = await db.query('Scans');
    final res = await db.query('Scans');

    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  //resgistros por tipo
  Future<List<ScanModel>> getScansPorTipo( String tipo ) async {

    final db = await database;
    //todas -> final res = await db.query('Scans');
    final res = await db.query('Scans', where: 'tipo =?', whereArgs: [tipo]);

    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  //actualizar registros
  //insertar un nuevo registro  
  Future<int> updateScan( ScanModel nuevoScan ) async {
    final db =  await database;
    final res = await db.update('Scans', nuevoScan.toJson(), where: 'id = ?', whereArgs: [nuevoScan.id]);
    return res;
  }

  //borrar registros
  Future<int> deleteScan( int id ) async {
    final db =  await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  //borrar todos registros
  Future<int> deleteAllScan() async {
    final db =  await database;
    final res = await db.delete('Scans');
    return res;
  }
  
}