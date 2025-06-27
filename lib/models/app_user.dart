import 'dart:convert';

AppUser appUserFromJson(String str) => AppUser.fromJson(json.decode(str));

String appUserToJson(AppUser data) => json.encode(data.toJson());

class AppUser {
  final String? id;
  final String? name;
  final String? lastname;
  final String? phone;
  final String? email;
  final String? password;
  final bool? isAdmin;
  final bool? isActive;
  final bool? isMod;
  final int? salary;
  final int? commissionRate;
  final Reset? reset;
  final String? avatar;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AppUser({
    this.id,
    this.name,
    this.lastname,
    this.phone,
    this.email,
    this.password,
    this.isAdmin,
    this.isActive,
    this.isMod,
    this.salary,
    this.commissionRate,
    this.reset,
    this.avatar,
    this.createdAt,
    this.updatedAt,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
    id: json["_id"],
    name: json["name"],
    lastname: json["lastname"],
    phone: json["phone"],
    email: json["email"],
    password: json["password"],
    isAdmin: json["is_admin"],
    isActive: json["is_active"],
    isMod: json["is_mod"],
    salary: json["salary"],
    commissionRate: json["commissionRate"],
    reset: json["reset"] == null ? null : Reset.fromJson(json["reset"]),
    avatar: json["avatar"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "lastname": lastname,
    "phone": phone,
    "email": email,
    "password": password,
    "is_admin": isAdmin,
    "is_active": isActive,
    "is_mod": isMod,
    "salary": salary,
    "commissionRate": commissionRate,
    "reset": reset?.toJson(),
    "avatar": avatar,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class Reset {
  final dynamic code;
  final dynamic time;

  Reset({this.code, this.time});

  factory Reset.fromJson(Map<String, dynamic> json) =>
      Reset(code: json["code"], time: json["time"]);

  Map<String, dynamic> toJson() => {"code": code, "time": time};
}
