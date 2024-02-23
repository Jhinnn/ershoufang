import 'dart:convert';

import 'package:ershoufang/model/building_count_model.dart';
import 'package:ershoufang/model/history_price_model.dart';
import 'package:ershoufang/model/house_model.dart';
import 'package:ershoufang/sql/table_define.dart';
import 'package:sqflite/sqlite_api.dart';

import '../table_operation.dart';

class HouseTable extends TableOperation {
  Future<List<HouseModel>> query() async {
    List<Map<String, Object?>> data = await dDatabase.query(ErShouFangTableDefine.houseTable);
    return List.generate(data.length, (index) {
      return HouseModel.fromJson(data[index]);
    });
  }

  Future<int> querytotal() async {
    List<Map<String, Object?>> data = await dDatabase.query(ErShouFangTableDefine.houseTable);
    return data.length;
  }

  Future<List<HouseModel>> queryByRegion(String region) async {
    List<Map<String, Object?>> data = await dDatabase.query(ErShouFangTableDefine.houseTable, where: 'region = ?', whereArgs: [region]);
    return List.generate(data.length, (index) {
      return HouseModel.fromJson(data[index]);
    });
  }

  Future<List<HouseModel>> queryByBuildName(String buildName) async {
    List<Map<String, Object?>> data = await dDatabase.query(ErShouFangTableDefine.houseTable, where: 'buildName = ?', whereArgs: [buildName]);
    return List.generate(data.length, (index) {
      return HouseModel.fromJson(data[index]);
    });
  }

  Future<List<BuildingCountModel>> queryBuildingsByRegion(String region) async {
    List<Map<String, Object?>> data = await dDatabase.rawQuery('SELECT buildName,count(*) as count FROM houseTable WHERE region= "$region"  GROUP BY buildName', [region]);
    return List.generate(data.length, (index) {
      return BuildingCountModel.fromJson(data[index]);
    });
  }

  Future<int> queryHouse(String houseId) async {
    List<Map<String, Object?>> data = await dDatabase.query(ErShouFangTableDefine.houseTable, where: 'houseId = ?', whereArgs: [houseId]);
    return data.length;
  }

  Future<List<HistoryPriceModel>> queryHousePrices(String houseId) async {
    List<Map<String, Object?>> data = await dDatabase.query(ErShouFangTableDefine.houseTable, columns: ['priceList'], where: 'houseId = ?', whereArgs: [houseId]);

    for (var element in data) {
      String comments = element['priceList'] as String;
      List<String> list = comments.split('|');
      if (list.length == 1) {
        return [HistoryPriceModel.fromJson(jsonDecode(comments))];
      } else {
        return list.map((e) => HistoryPriceModel.fromJson(jsonDecode(comments))).toList();
      }
    }
    return [];
  }

  Future<int> insertHouseModel(HouseModel model) async {
    int priceLength = await queryHouse(model.houseId);
    if (priceLength > 0 && priceLength < model.priceList.length) {
      int result = await dDatabase.insert(ErShouFangTableDefine.houseTable, model.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
      return result;
    } else {
      return 0;
    }
  }

  // clearMoment() async {
  //   dDatabase.delete(ErShouFangTableDefine.houseTable);
  // }
}
