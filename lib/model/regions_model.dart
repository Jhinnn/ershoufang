class CityModel {
  String city;
  List<RegionsModel> region;

  CityModel({required this.city, required this.region});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> regionList = json['region'];
    List<RegionsModel> regions = regionList.map((region) => RegionsModel.fromJson(region)).toList();

    return CityModel(
      city: json['city'],
      region: regions,
    );
  }
}

class RegionsModel {
  String region;
  List<BuildingModel> buildings;

  RegionsModel({required this.region, required this.buildings});

  factory RegionsModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> buildingList = json['buildings'];
    List<BuildingModel> buildings = buildingList.map((building) => BuildingModel.fromJson(building)).toList();

    return RegionsModel(
      region: json['region'],
      buildings: buildings,
    );
  }
}

class BuildingModel {
  String name;
  String pinyin;
  int length;

  BuildingModel({required this.name, required this.pinyin, required this.length});

  factory BuildingModel.fromJson(Map<String, dynamic> json) {
    return BuildingModel(
      name: json['name'],
      pinyin: json['pinyin'],
      length: json['length'],
    );
  }
}
