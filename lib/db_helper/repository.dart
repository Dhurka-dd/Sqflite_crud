import 'package:crud_sqllite_app/db_helper/database_connection.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  late DatabaseConnection _databaseConnection;
  Repository() {
    _databaseConnection = DatabaseConnection();
  }

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }

  //Insert user
  insertData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  //Read all record
  readData(table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  //Read a single record by id
  readDataById(table, userId) async {
    var connection = await database;
    return await connection?.query(table, where: 'id=?', whereArgs: [userId]);
  }

  //update user
  updateData(table, data) async {
    var connection = await database;
    return await connection
        ?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  //delete user
  deleteDataById(table, userId) async {
    var connection = await database;
    return await connection?.rawDelete("delete from $table where id=$userId");
  }
}
