class SubOrderModel {
  String? status;
  List<Data>? data;
  bool? isAdmin;

  SubOrderModel({this.status, this.data, this.isAdmin});

  SubOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    isAdmin = json['isAdmin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['isAdmin'] = this.isAdmin;
    return data;
  }
}

class Data {
  String? name;
  String? email;
  String? phoneNumber;
  List<Products>? products;
  int? status;
  int? orderId;
  String? note;
  String? dateTime;

  Data(
      {this.name,
        this.email,
        this.phoneNumber,
        this.products,
        this.status,
        this.orderId,
        this.note,
        this.dateTime});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    status = json['status'];
    orderId = json['orderId'];
    note = json['note'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['orderId'] = this.orderId;
    data['note'] = this.note;
    data['dateTime'] = this.dateTime;
    return data;
  }
}

class Products {
  int? productId;
  String? engName;
  String? imageUrl;
  String? araName;
  double? price;
  int? quantity;

  Products(
      {this.productId,
        this.engName,
        this.imageUrl,
        this.araName,
        this.price,
        this.quantity});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    engName = json['engName'];
    imageUrl = json['imageUrl'];
    araName = json['araName'];
    price = json['price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['engName'] = this.engName;
    data['imageUrl'] = this.imageUrl;
    data['araName'] = this.araName;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    return data;
  }
}