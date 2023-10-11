import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class SignupResponseModel {
  String? name;
  String? email;
  String? phoneNumber;
  String? password;
  int? branchId;

  SignupResponseModel({
    this.name,
    this.email,
    this.phoneNumber,
    this.password,
    this.branchId,
  });

  SignupResponseModel copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? password,
    int? branchId,
  }) {
    return SignupResponseModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      branchId: branchId ?? this.branchId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'branchId': branchId,
    };
  }

  factory SignupResponseModel.fromMap(Map<String, dynamic> map) {
    return SignupResponseModel(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      branchId: map['branchId'] != null ? map['branchId'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignupResponseModel.fromJson(String source) =>
      SignupResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SignupResponseModel(name: $name, email: $email, phoneNumber: $phoneNumber, password: $password, branchId: $branchId)';
  }

  @override
  bool operator ==(covariant SignupResponseModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.password == password &&
        other.branchId == branchId;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        password.hashCode ^
        branchId.hashCode;
  }
}
