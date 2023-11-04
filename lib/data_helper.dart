import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "IndividualDetailsDB.db";
  static const _databaseVersion = 4;


  static const individualDetailsTable = 'IndividualTable';

  static const colId = '_id';

  static const colfirstName = '_firstName';
  static const collastName = '_lastName';
  static const colbusinessName = '_businessName';
  static const coldateOfBusiness = '_dateOfBusiness';
  static const colnatureOfBusiness = '_natureOfBusiness';
  static const colpanNumber = '_panNumber';
  static const colgstNumber = '_gstNumber';


  late Database _db;


  Future<void> initialization() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);

    _db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onCreate(Database database, int version) async {
    await database.execute('''
        CREATE TABLE $individualDetailsTable(
        $colId INTEGER PRIMARY KEY,
        $colfirstName TEXT,
        $collastName TEXT,
        $colbusinessName TEXT,
        $coldateOfBusiness TEXT,
        $colnatureOfBusiness TEXT,
        $colpanNumber TEXT,
        $colgstNumber TEXT)

     ''');
  }

  _onUpgrade(Database database, int oldVersion, int newVersion) async {
    await database.execute('drop table $individualDetailsTable');
    _onCreate(database, newVersion);
  }

  Future<int> insertIndividualDetailsTable(
      Map<String, dynamic> row, String tableName) async {
    return await _db.insert(tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows(String tableName) async {
    return await _db.query(tableName);
  }

  Future<int> updateIndividualDetailsTable(
      Map<String, dynamic> row, String tableName) async {
    int id = row[colId];
    return await _db.update(
      tableName,
      row,
      where: '$colId =?',
      whereArgs: [id],
    );
  }
  Future<int>deleteIndividualDetailsTable(int id,String tableName) async{
    return await _db.delete(
      tableName,
      where: '$colId = ?',
      whereArgs: [id],
    );
  }
}
