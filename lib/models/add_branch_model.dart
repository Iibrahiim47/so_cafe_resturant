// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AddBranchModel {
  String? name;
  String? address;

  AddBranchModel({
    this.name,
    this.address,
  });

  AddBranchModel copyWith({
    String? name,
    String? address,
  }) {
    return AddBranchModel(
      name: name ?? this.name,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'address': address,
    };
  }

  factory AddBranchModel.fromMap(Map<String, dynamic> map) {
    return AddBranchModel(
      name: map['name'] != null ? map['name'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddBranchModel.fromJson(String source) =>
      AddBranchModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AddBranchModel(name: $name, address: $address)';

  @override
  bool operator ==(covariant AddBranchModel other) {
    if (identical(this, other)) return true;

    return other.name == name && other.address == address;
  }

  @override
  int get hashCode => name.hashCode ^ address.hashCode;
}
