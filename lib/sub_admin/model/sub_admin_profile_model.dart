class SubAdminProfileModel {
  String? status;
  Data? data;
  bool? isAdmin;

  SubAdminProfileModel({this.status, this.data, this.isAdmin});

  SubAdminProfileModel.fromJson(Map<String, dynamic> json) {
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
  int? branchId;
  String? branchName;
  String? branchAddress;
  String? branchDate;
  String? registrationDateTime;

  Data(
      {this.userId,
      this.name,
      this.email,
      this.phoneNumber,
      this.branchId,
      this.branchName,
      this.branchAddress,
      this.branchDate,
      this.registrationDateTime});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    branchId = json['branchId'];
    branchName = json['branchName'];
    branchAddress = json['branchAddress'];
    branchDate = json['branchDate'];
    registrationDateTime = json['registrationDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['branchId'] = branchId;
    data['branchName'] = branchName;
    data['branchAddress'] = branchAddress;
    data['branchDate'] = branchDate;
    data['registrationDateTime'] = registrationDateTime;
    return data;
  }
}
