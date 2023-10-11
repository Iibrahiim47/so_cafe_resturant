class GetBranchModel {
  String? status;
  List<Data>? data;
  bool? isAdmin;

  GetBranchModel({this.status, this.data, this.isAdmin});

  GetBranchModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  int? branchId;
  String? address;
  String? registrationDateTime;

  Data({this.name, this.branchId, this.address, this.registrationDateTime});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    branchId = json['branchId'];
    address = json['address'];
    registrationDateTime = json['registrationDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['branchId'] = branchId;
    data['address'] = address;
    data['registrationDateTime'] = registrationDateTime;
    return data;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'branchId': branchId,
      'address': address,
      'registrationDateTime': registrationDateTime,
    };
  }
}
