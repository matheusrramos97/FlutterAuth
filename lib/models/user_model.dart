import 'dart:convert';

class UserModel {
  final String name;
  final String photoURL;
  final String email;
  final String signInMethod;

  UserModel(
      {required this.name,
      required this.photoURL,
      required this.email,
      required this.signInMethod});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        name: map['name'],
        photoURL: map['photoURL'],
        email: map['email'],
        signInMethod: map['signInMethod']);
  }

  factory UserModel.fromJson(String json) =>
      UserModel.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap() => {
        'name': name,
        'photoURL': photoURL,
        'email': email,
        'signInMethod': signInMethod
      };

  String toJson() => jsonEncode(toMap());
}
