// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginReqModel {
  String? email;
  String? password;

  LoginReqModel({
    this.email,
    this.password,
  });

  LoginReqModel copyWith({
    String? email,
    String? password,
  }) {
    return LoginReqModel(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory LoginReqModel.fromMap(Map<String, dynamic> map) {
    return LoginReqModel(
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginReqModel.fromJson(String source) =>
      LoginReqModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LoginReqModel(email: $email, password: $password)';

  @override
  bool operator ==(covariant LoginReqModel other) {
    if (identical(this, other)) return true;

    return other.email == email && other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}

class LoginResponse {
  String? status;
  String? data;
  bool? isAdmin;

  LoginResponse({
    this.status,
    this.data,
    this.isAdmin,
  });

  LoginResponse copyWith({
    String? status,
    String? data,
    bool? isAdmin,
  }) {
    return LoginResponse(
      status: status ?? this.status,
      data: data ?? this.data,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'data': data,
      'isAdmin': isAdmin,
    };
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      status: map['status'] != null ? map['status'] as String : null,
      data: map['data'] != null ? map['data'] as String : null,
      isAdmin: map['isAdmin'] != null ? map['isAdmin'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromJson(String source) =>
      LoginResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LoginResponse(status: $status, data: $data, isAdmin: $isAdmin)';

  @override
  bool operator ==(covariant LoginResponse other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.data == data &&
        other.isAdmin == isAdmin;
  }

  @override
  int get hashCode => status.hashCode ^ data.hashCode ^ isAdmin.hashCode;
}
