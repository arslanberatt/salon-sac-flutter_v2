import 'dart:convert';

AppTransaction appTransactionFromJson(String str) =>
    AppTransaction.fromJson(json.decode(str));

String appTransactionToJson(AppTransaction data) => json.encode(data.toJson());

class AppTransaction {
  final String? id;
  final double? amount;
  final String? description;
  final DateTime? date;
  final String? userId;
  final Category? category;
  final String? createdBy;
  final bool? canceled;
  final DateTime? canceledAt;
  final String? canceledBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AppTransaction({
    this.id,
    this.amount,
    this.description,
    this.date,
    this.userId,
    this.category,
    this.createdBy,
    this.canceled,
    this.canceledAt,
    this.canceledBy,
    this.createdAt,
    this.updatedAt,
  });

  factory AppTransaction.fromJson(Map<String, dynamic> json) => AppTransaction(
    id: json["_id"],
    amount: json["amount"],
    description: json["description"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    userId: json["user_id"],
    category: json["category"] == null
        ? null
        : Category.fromJson(json["category"]),
    createdBy: json["createdBy"],
    canceled: json["canceled"],
    canceledAt: json["canceledAt"] == null
        ? null
        : DateTime.parse(json["canceledAt"]),
    canceledBy: json["canceledBy"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() {
    String? isoDate;
    if (date != null) {
      final s = date!.toUtc().toIso8601String();
      isoDate = s.split(".").first + "Z";
    }

    return {
      "_id": id,
      "amount": amount,
      "description": description,
      "date": isoDate,
      "user_id": userId,
      "category": category?.toJson(),
      "createdBy": createdBy,
      "canceled": canceled,
      "canceledAt": canceledAt?.toUtc().toIso8601String(),
      "canceledBy": canceledBy,
      "createdAt": createdAt?.toUtc().toIso8601String(),
      "updatedAt": updatedAt?.toUtc().toIso8601String(),
    };
  }
}

class Category {
  final String? id;
  final String? name;
  final String? type;

  Category({this.id, this.name, this.type});

  factory Category.fromJson(Map<String, dynamic> json) =>
      Category(id: json["_id"], name: json["name"], type: json["type"]);

  Map<String, dynamic> toJson() => {"_id": id, "name": name, "type": type};
}
