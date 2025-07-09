class AppAdvance {
  final String? id;
  final double? amount;
  final String? reason;
  final String? status;
  final DateTime? createdAt;
  final EmployeeRef? employee;

  AppAdvance({
    this.id,
    this.amount,
    this.reason,
    this.status,
    this.createdAt,
    this.employee,
  });

  factory AppAdvance.fromJson(Map<String, dynamic> json) {
    final dynamic emp = json['employeeId'];
    EmployeeRef? parsedEmployee;
    if (emp is Map<String, dynamic>) {
      parsedEmployee = EmployeeRef.fromJson(emp);
    }

    return AppAdvance(
      id: json['_id'],
      amount: (json["amount"] as num?)?.toDouble(),
      reason: json['reason'],
      status: json['status'],
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      employee: parsedEmployee,
    );
  }
}

class EmployeeRef {
  final String? id;
  final String? name;
  final String? lastname;

  EmployeeRef({this.id, this.name, this.lastname});

  factory EmployeeRef.fromJson(Map<String, dynamic> json) {
    return EmployeeRef(
      id: json['_id'],
      name: json['name'],
      lastname: json['lastname'],
    );
  }
}
