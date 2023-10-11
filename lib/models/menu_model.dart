// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MenuModelClass {
  String? name;
  String? arabicName;
  String? image;
  String? description;
  String? price;
  String? catId;

  MenuModelClass({
    this.name,
    this.arabicName,
    this.image,
    this.description,
    this.price,
    this.catId,
  });

  MenuModelClass copyWith({
    String? name,
    String? arabicName,
    String? image,
    String? description,
    String? price,
    String? catId,
  }) {
    return MenuModelClass(
      name: name ?? this.name,
      arabicName: arabicName ?? this.arabicName,
      image: image ?? this.image,
      description: description ?? this.description,
      price: price ?? this.price,
      catId: catId ?? this.catId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'arabicName': arabicName,
      'image': image,
      'description': description,
      'price': price,
      'catId': catId,
    };
  }

  factory MenuModelClass.fromMap(Map<String, dynamic> map) {
    return MenuModelClass(
      name: map['name'] != null ? map['name'] as String : null,
      arabicName:
          map['arabicName'] != null ? map['arabicName'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
      catId: map['catId'] != null ? map['catId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MenuModelClass.fromJson(String source) =>
      MenuModelClass.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MenuModelClass(name: $name, arabicName: $arabicName, image: $image, description: $description, price: $price, catId: $catId)';
  }

  @override
  bool operator ==(covariant MenuModelClass other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.arabicName == arabicName &&
        other.image == image &&
        other.description == description &&
        other.price == price &&
        other.catId == catId;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        arabicName.hashCode ^
        image.hashCode ^
        description.hashCode ^
        price.hashCode ^
        catId.hashCode;
  }
}
