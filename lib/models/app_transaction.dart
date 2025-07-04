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
  bool? canceled;
  final DateTime? canceledAt;
  final String? canceledBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? type;

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
    this.type,
  });

  factory AppTransaction.fromJson(Map<String, dynamic> json) => AppTransaction(
    id: json["_id"] as String?,
    amount: (json["amount"] as num?)?.toDouble(),
    description: json["description"] as String?,
    date: json["date"] != null ? DateTime.parse(json["date"] as String) : null,
    createdBy: json["createdBy"] is Map
        ? json["createdBy"]["_id"] as String?
        : json["createdBy"] as String?,
    userId: json["user_id"] as String?,
    category: json["category"] is Map<String, dynamic>
        ? Category.fromJson(json["category"] as Map<String, dynamic>)
        : Category(id: json["category"] as String?), // ← düzeltme burada!
    canceled: json["canceled"] as bool?,
    canceledAt: json["canceledAt"] != null
        ? DateTime.parse(json["canceledAt"] as String)
        : null,
    canceledBy: json["canceledBy"] as String?,
    createdAt: json["createdAt"] != null
        ? DateTime.parse(json["createdAt"] as String)
        : null,
    updatedAt: json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"] as String)
        : null,
    type: json["type"] as String?,
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
      "type": type, // ✅ json’a yazıldı
    };
  }

  @override
  String toString() {
    return 'AppTransaction(id: $id, amount: $amount, desc: $description, date: $date, category: ${category?.name}, type: $type)';
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
