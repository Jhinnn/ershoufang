class ErShouFangTableDefine {
  static const String houseTable = 'houseTable';

  /*
    存储类             描述
     
    NULL              值是一个 NULL 值。
    
    INTEGER           值是一个带符号的整数，-2^63 到 2^63 - 1
    
    REAL              值是一个数字类型，dart中的 num
    
    TEXT              值是一个文本字符串，dart中的 String
    
    BLOB              值是一个 blob 数据，dart中的 Uint8List 或者 List<int> 

    */
  createHouseTable() {
    return '''
      CREATE TABLE IF NOT EXISTS $houseTable (
        "id" INTEGER NOT NULL PRIMARY KEY,
        "houseId" TEXT,
        "cover"  TEXT,
        "description"  TEXT,
        "houseType"  TEXT,
        "floor" TEXT,
        "area"  TEXT,
        "region" TEXT,
        "buildName" TEXT,
        "url"  TEXT,
        "follows"  TEXT,
        "publishTime"  TEXT,
        "priceList"  TEXT
      );
      ''';
  }

  /*
  final String houseId;
  final String cover;
  final String description;
  final String houseType;
  final String floor;
  final String area;
  final String address;
  final String url;
  final String follows;
  final String publishTime;
  final List<HistoryPriceModel> priceList;
  */
}
