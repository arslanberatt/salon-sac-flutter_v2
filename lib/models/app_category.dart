import 'dart:convert';

AppCategory appCategoryFromJson(String str) =>
    AppCategory.fromJson(json.decode(str));

String appCategoryToJson(AppCategory data) => json.encode(data.toJson());

class AppCategory {
  final String? id;
  final String? name;
  final String? type;

  AppCategory({this.id, this.name, this.type});

  factory AppCategory.fromJson(Map<String, dynamic> json) =>
      AppCategory(id: json["_id"], name: json["name"], type: json["type"]);

  Map<String, dynamic> toJson() => {"_id": id, "name": name, "type": type};

}
