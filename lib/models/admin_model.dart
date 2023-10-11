import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class AdminModel {
  String? fullName;
  String? branchaddress;
  String? adminId;
  String? email;
  String? number;
  String? password;
  String? branchName;
  String? branchId;
  String? dateTime;
  String? addedBY;

  AdminModel({
    this.fullName,
    this.branchaddress,
    this.adminId,
    this.email,
    this.number,
    this.password,
    this.branchName,
    this.branchId,
    this.dateTime,
    this.addedBY,
  });

  AdminModel copyWith({
    String? fullName,
    String? branchaddress,
    String? adminId,
    String? email,
    String? number,
    String? password,
    String? branchName,
    String? branchId,
    String? dateTime,
    String? addedBY,
  }) {
    return AdminModel(
      fullName: fullName ?? this.fullName,
      branchaddress: branchaddress ?? this.branchaddress,
      adminId: adminId ?? this.adminId,
      email: email ?? this.email,
      number: number ?? this.number,
      password: password ?? this.password,
      branchName: branchName ?? this.branchName,
      branchId: branchId ?? this.branchId,
      dateTime: dateTime ?? this.dateTime,
      addedBY: addedBY ?? this.addedBY,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'branchaddress': branchaddress,
      'adminId': adminId,
      'email': email,
      'number': number,
      'password': password,
      'branchName': branchName,
      'branchId': branchId,
      'dateTime': dateTime,
      'addedBY': addedBY,
    };
  }

  factory AdminModel.fromMap(Map<String, dynamic> map) {
    return AdminModel(
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      branchaddress:
          map['branchaddress'] != null ? map['branchaddress'] as String : null,
      adminId: map['adminId'] != null ? map['adminId'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      number: map['number'] != null ? map['number'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      branchName:
          map['branchName'] != null ? map['branchName'] as String : null,
      branchId: map['branchId'] != null ? map['branchId'] as String : null,
      dateTime: map['dateTime'] != null ? map['dateTime'] as String : null,
      addedBY: map['addedBY'] != null ? map['addedBY'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminModel.fromJson(String source) =>
      AdminModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AdminModel(fullName: $fullName, branchaddress: $branchaddress, adminId: $adminId, email: $email, number: $number, password: $password, branchName: $branchName, branchId: $branchId, dateTime: $dateTime, addedBY: $addedBY)';
  }

  @override
  bool operator ==(covariant AdminModel other) {
    if (identical(this, other)) return true;

    return other.fullName == fullName &&
        other.branchaddress == branchaddress &&
        other.adminId == adminId &&
        other.email == email &&
        other.number == number &&
        other.password == password &&
        other.branchName == branchName &&
        other.branchId == branchId &&
        other.dateTime == dateTime &&
        other.addedBY == addedBY;
  }

  @override
  int get hashCode {
    return fullName.hashCode ^
        branchaddress.hashCode ^
        adminId.hashCode ^
        email.hashCode ^
        number.hashCode ^
        password.hashCode ^
        branchName.hashCode ^
        branchId.hashCode ^
        dateTime.hashCode ^
        addedBY.hashCode;
  }
}
