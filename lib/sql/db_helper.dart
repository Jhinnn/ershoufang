import 'dart:io';
import 'package:ershoufang/sql/table/house_table.dart';
import 'package:ershoufang/sql/table_define.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

import 'package:path_provider/path_provider.dart';

/// 数据库帮助类
class DbHelper {
  ErShouFangTableDefine erShouFangTableDefine = ErShouFangTableDefine();
  HouseTable houseTable = HouseTable();

  //私有构造
  DbHelper._();
  static DbHelper? _instance;
  static DbHelper get instance => _getInstance();
  factory DbHelper() {
    return instance;
  }
  static DbHelper _getInstance() {
    _instance ??= DbHelper._();
    return _instance ?? DbHelper._();
  }

  /// 数据库默认存储的路径
  /// SQLite 数据库是文件系统中由路径标识的文件。如果是relative，
  /// 这个路径是相对于 获取的路径getDatabasesPath()，
  /// Android默认的数据库目录，
  /// iOS/MacOS的documents目录。

  Future<Database>? _db;

  Future<Database>? getDb() {
    _db ??= _initDb();
    return _db;
  }

  Future<Database> _initDb() async {
    Directory path = await getApplicationDocumentsDirectory();
    print(p.join(path.path, 'house', 'house.db'));
    final db = await openDatabase(p.join(path.path, 'house', 'house.db'),
        version: 1, onCreate: (db, version) {
      db.execute(erShouFangTableDefine.createHouseTable());
    }, onUpgrade: (db, oldV, newV) {});

    houseTable.database = db;

    return db;
  }

  close() async {
    await _db?.then((value) => value.close());
  }
}
