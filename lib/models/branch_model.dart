// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BranchModel {
  String? branchName;
  String? branchAddress;
  String? branchId;
  String? addedBy;
  String? dateTime;

  BranchModel({
    this.branchName,
    this.branchAddress,
    this.branchId,
    this.addedBy,
    this.dateTime,
  });

  BranchModel copyWith({
    String? branchName,
    String? branchAddress,
    String? branchId,
    String? addedBy,
    String? dateTime,
  }) {
    return BranchModel(
      branchName: branchName ?? this.branchName,
      branchAddress: branchAddress ?? this.branchAddress,
      branchId: branchId ?? this.branchId,
      addedBy: addedBy ?? this.addedBy,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'branchName': branchName,
      'branchAddress': branchAddress,
      'branchId': branchId,
      'addedBy': addedBy,
      'dateTime': dateTime,
    };
  }

  factory BranchModel.fromMap(Map<String, dynamic> map) {
    return BranchModel(
      branchName:
          map['branchName'] != null ? map['branchName'] as String : null,
      branchAddress:
          map['branchAddress'] != null ? map['branchAddress'] as String : null,
      branchId: map['branchId'] != null ? map['branchId'] as String : null,
      addedBy: map['addedBy'] != null ? map['addedBy'] as String : null,
      dateTime: map['dateTime'] != null ? map['dateTime'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BranchModel.fromJson(String source) =>
      BranchModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BranchModel(branchName: $branchName, branchAddress: $branchAddress, branchId: $branchId, addedBy: $addedBy, dateTime: $dateTime)';
  }

  @override
  bool operator ==(covariant BranchModel other) {
    if (identical(this, other)) return true;

    return other.branchName == branchName &&
        other.branchAddress == branchAddress &&
        other.branchId == branchId &&
        other.addedBy == addedBy &&
        other.dateTime == dateTime;
  }

  @override
  int get hashCode {
    return branchName.hashCode ^
        branchAddress.hashCode ^
        branchId.hashCode ^
        addedBy.hashCode ^
        dateTime.hashCode;
  }
}
