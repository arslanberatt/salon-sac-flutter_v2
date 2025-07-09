// To parse this JSON data, do
//
//     final appSalary = appSalaryFromJson(jsonString);

import 'dart:convert';

AppSalary appSalaryFromJson(String str) => AppSalary.fromJson(json.decode(str));

String appSalaryToJson(AppSalary data) => json.encode(data.toJson());

class AppSalary {
  final String? id;
  final EmployeeId? employeeId;
  final String? type;
  final double? amount;
  final String? description;
  final bool? approved;
  final DateTime? date;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AppSalary({
    this.id,
    this.employeeId,
    this.type,
    this.amount,
    this.description,
    this.approved,
    this.date,
    this.createdAt,
    this.updatedAt,
  });

  factory AppSalary.fromJson(Map<String, dynamic> json) => AppSalary(
    id: json["_id"],
    employeeId: json["employeeId"] is Map
        ? EmployeeId.fromJson(json["employeeId"])
        : null,
    type: json["type"],
    amount: (json["amount"] as num?)?.toDouble(),
    description: json["description"],
    approved: json["approved"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "employeeId": employeeId?.toJson(),
    "type": type,
    "amount": amount,
    "description": description,
    "approved": approved,
    "date": date?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class EmployeeId {
  final String? id;
  final String? name;
  final String? lastname;

  EmployeeId({this.id, this.name, this.lastname});

  factory EmployeeId.fromJson(Map<String, dynamic> json) => EmployeeId(
    id: json["_id"],
    name: json["name"],
    lastname: json["lastname"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "lastname": lastname,
  };
}
