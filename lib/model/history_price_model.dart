class HistoryPriceModel {
  final String houseId;
  final String price;
  final String totalPrice;
  final int time;

  HistoryPriceModel({
    required this.houseId,
    required this.price,
    required this.time,
    required this.totalPrice
  });

  factory HistoryPriceModel.fromJson(Map<String, dynamic> json) {
    return HistoryPriceModel(
      houseId: json['house_id'] as String,
      time: json['time'] as int,
      price: json['price'] as String,
      totalPrice: json['total_price'] as String
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'house_id': houseId,
      'price': price,
      'total_price': totalPrice,
      'time': time,
      
    };
  }
}
