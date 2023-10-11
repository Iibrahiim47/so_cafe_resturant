class GetReviewsModel {
  String? status;
  List<Data>? data;
  bool? isAdmin;

  GetReviewsModel({this.status, this.data, this.isAdmin});

  GetReviewsModel.fromJson(Map<String, dynamic> json) {
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
  String? email;
  String? phoneNumber;
  String? aboutus;
  String? city;
  String? improve;
  double? staffRating;
  double? serviceRating;
  bool? firstTime;
  String? registrationDateTime;

  Data(
      {this.name,
      this.email,
      this.phoneNumber,
      this.aboutus,
      this.city,
      this.improve,
      this.staffRating,
      this.serviceRating,
      this.firstTime,
      this.registrationDateTime});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    aboutus = json['aboutus'];
    city = json['city'];
    improve = json['improve'];
    staffRating = json['staffRating'];
    serviceRating = json['serviceRating'];
    firstTime = json['firstTime'];
    registrationDateTime = json['registrationDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['aboutus'] = aboutus;
    data['city'] = city;
    data['improve'] = improve;
    data['staffRating'] = staffRating;
    data['serviceRating'] = serviceRating;
    data['firstTime'] = firstTime;
    data['registrationDateTime'] = registrationDateTime;
    return data;
  }
}
