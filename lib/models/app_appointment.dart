import 'dart:convert';
import 'app_service.dart';
import 'app_user.dart';

AppAppointment appAppointmentFromJson(String str) =>
    AppAppointment.fromJson(json.decode(str));

String appAppointmentToJson(AppAppointment data) => json.encode(data.toJson());

class AppAppointment {
  final String? id;
  final AppUser? employee;
  final String? customerName;
  final String? customerPhone;
  final List<AppService> services;
  final DateTime? startTime;
  final bool? isDone;
  final bool? isCancelled;
  final double? price;
  final String? notes;

  AppAppointment({
    this.id,
    this.employee,
    this.customerName,
    this.customerPhone,
    this.services = const [],
    this.startTime,
    this.isDone,
    this.isCancelled,
    this.price,
    this.notes,
  });

  factory AppAppointment.fromJson(Map<String, dynamic> json) {
    final empJson = json['employee_id'];
    AppUser? emp;
    if (empJson is Map<String, dynamic>) {
      emp = AppUser.fromJson(empJson);
    } else if (empJson is String) {
      emp = AppUser(id: empJson);
    }

    final rawSvcs = json['services'] as List<dynamic>? ?? [];
    final svcs = rawSvcs.map((e) {
      if (e is Map<String, dynamic>) {
        return AppService.fromJson(e);
      } else if (e is String) {
        return AppService(id: e, name: '', duration: 0, price: 0);
      }
      throw Exception('Invalid service entry: \$e');
    }).toList();

    return AppAppointment(
      id: json['_id'] as String?,
      employee: emp,
      customerName: json['customer_name'] as String?,
      customerPhone: json['customer_phone'] as String?,
      services: svcs,
      startTime: json['start_time'] != null
          ? DateTime.parse(json['start_time'] as String)
          : null,
      isDone: json['is_done'] as bool? ?? false,
      isCancelled: json['is_cancelled'] as bool? ?? false,
      price: (json['price'] as num?)?.toDouble(),
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      if (employee != null) 'employee_id': employee!.id,
      if (customerName != null) 'customer_name': customerName,
      if (customerPhone != null) 'customer_phone': customerPhone,
      'services': services.map((s) => s.id).toList(),
      if (startTime != null) 'start_time': startTime!.toIso8601String(),
      if (isDone != null) 'is_done': isDone,
      if (isCancelled != null) 'is_cancelled': isCancelled,
      if (price != null) 'price': price,
      if (notes != null) 'notes': notes,
    };
  }

  /// Returns a modified copy of this appointment
  AppAppointment copyWith({
    String? id,
    AppUser? employee,
    String? customerName,
    String? customerPhone,
    List<AppService>? services,
    DateTime? startTime,
    bool? isDone,
    bool? isCancelled,
    double? price,
    String? notes,
  }) {
    return AppAppointment(
      id: id ?? this.id,
      employee: employee ?? this.employee,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      services: services ?? this.services,
      startTime: startTime ?? this.startTime,
      isDone: isDone ?? this.isDone,
      isCancelled: isCancelled ?? this.isCancelled,
      price: price ?? this.price,
      notes: notes ?? this.notes,
    );
  }
}
