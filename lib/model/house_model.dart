import 'dart:convert';

import 'package:ershoufang/model/history_price_model.dart';

class HouseModel {
  final String houseId;
  final String cover;
  final String description;
  final String houseType;
  final String floor;
  final String area;
  final String buildName;
  final String region;
  final String url;
  final String follows;
  final String publishTime;
  final List<HistoryPriceModel> priceList;

  HouseModel({
    required this.houseId,
    required this.cover,
    required this.description,
    required this.houseType,
    required this.floor,
    required this.area,
    required this.buildName,
    required this.region,
    required this.url,
    required this.follows,
    required this.publishTime,
    required this.priceList,
  });

  factory HouseModel.fromJson(Map<String, dynamic> json) {
    final String? comments = json['priceList'];

    List<HistoryPriceModel> pricesList = [];
    if (comments == "") {
    } else {
      final List<String> prices = comments!.split("|");
      pricesList = prices.map((e) {
        var v = jsonDecode(e);
        var x = HistoryPriceModel.fromJson(v);
        return x;
      }).toList();
    }

    return HouseModel(
      houseId: json['houseId'] as String,
      cover: json['cover'] as String,
      description: json['description'] as String,
      area: json['area'] as String,
      region: json['region'] as String,
      houseType: json['houseType'] as String,
      buildName: json['buildName'] as String,
      floor: json['floor'] as String,
      priceList: pricesList,
      url: json['url'] as String,
      follows: json['follows'] as String,
      publishTime: json['publishTime'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'houseId': houseId,
      'cover': cover,
      'description': description,
      'area': area,
      'houseType': houseType,
      'floor': floor,
      'region': region,
      'buildName': buildName,
      'url': url,
      'follows': follows,
      'publishTime': publishTime,
      'priceList': priceList.map((e) => jsonEncode(e.toJson())).toList().join('|'),
    };
  }
}
