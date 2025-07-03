import 'dart:convert';

AppService appServiceFromJson(String str) =>
    AppService.fromJson(json.decode(str));

String appServiceToJson(AppService data) => json.encode(data.toJson());

class AppService {
  final String? id;
  final String? name;
  final int? duration;
  final double? price;

  AppService({this.id, this.name, this.duration, this.price});

  factory AppService.fromJson(Map<String, dynamic> json) => AppService(
    id: json["_id"] as String?,
    name: json["name"] as String?,
    duration: json["duration"] as int?,
    price: (json["price"] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "duration": duration,
    "price": price,
  };
}
