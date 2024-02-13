import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class SqlDb{

  static Database? _db;

  Future<Database?> get db async{
    if(_db == null){
      _db = await initialDb();
      return _db;
    }
    else {
      return _db;
    }
  }
 
  initialDb()async{
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'recipe.dp');
    Database recipeDb = await openDatabase(path, onCreate: _onCreate,version: 1);
    return recipeDb;
  }

  _onCreate(Database dp, int version){
    dp.execute('CREATE TABLE favouriteRecipes (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, photo TEXT NOT NULL, fakeId INT NOT NULL)');
    print('onCreate =======================');
  }

    Future<List<Map>> readData(String sql) async {
    Database? myDp = await db;
    List<Map> response = await myDp!.rawQuery(sql);
    return response;
  }

  Future<int> insertData(String sql) async {
    Database? myDp = await db;
    int response = await myDp!.rawInsert(sql);
    return response;
  }

  Future<int> updateData(String sql) async {
    Database? myDp = await db;
    int response = await myDp!.rawUpdate(sql);
    return response;
  }

  Future<int> deleteData(String sql) async {
    Database? myDp = await db;
    int response = await myDp!.rawDelete(sql);
    return response;
  }

  onDeleteDataBase() async {
    String databasePath = await getDatabasesPath();
    String pathName = join(databasePath, 'recipe.dp');
    await deleteDatabase(pathName);
  }
}