class OwnerProfileModel {
  String? status;
  Data? data;
  bool? isAdmin;

  OwnerProfileModel({this.status, this.data, this.isAdmin});

  OwnerProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    isAdmin = json['isAdmin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['isAdmin'] = isAdmin;
    return data;
  }
}

class Data {
  int? userId;
  String? name;
  String? email;
  String? phoneNumber;
  String? registrationDateTime;

  Data(
      {this.userId,
      this.name,
      this.email,
      this.phoneNumber,
      this.registrationDateTime});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    registrationDateTime = json['registrationDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['registrationDateTime'] = registrationDateTime;
    return data;
  }
}
