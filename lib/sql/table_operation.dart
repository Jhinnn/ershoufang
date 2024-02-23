import 'package:sqflite/sqflite.dart';

class TableOperation {
  late Database _database;

  set database(Database database) => _database = database;

  Database get dDatabase => _database;
}
