class GetUsersProfile {
  String? status;
  List<Data>? data;
  bool? isAdmin;

  GetUsersProfile({this.status, this.data, this.isAdmin});

  GetUsersProfile.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    isAdmin = json['isAdmin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
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
  String? branchName;
  String? branchAddress;
  String? branchDate;
  String? registrationDateTime;

  Data(
      {this.userId,
      this.name,
      this.email,
      this.phoneNumber,
      this.branchName,
      this.branchAddress,
      this.branchDate,
      this.registrationDateTime});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
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
    data['branchName'] = branchName;
    data['branchAddress'] = branchAddress;
    data['branchDate'] = branchDate;
    data['registrationDateTime'] = registrationDateTime;
    return data;
  }
}
