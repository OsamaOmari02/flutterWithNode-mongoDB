import 'dart:convert';

UserModel dataUserModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str));

class UserModel {
  final String name;
  final String address;
  final String id;

  UserModel({required this.name,required this.address,required this.id});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    name: json['name'].toString(),
    address: json['address'].toString(),
    id: json['id'].toString(),
  );
}