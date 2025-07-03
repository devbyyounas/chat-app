// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String? name;
  String? email;
  String? password;
  String? number;
  String? userID;
  UserModel({
    this.name,
    this.email,
    this.password,
    this.number,
    this.userID,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    String? number,
    String? userID,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      number: number ?? this.number,
      userID: userID ?? this.userID,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'number': number,
      'userID': userID,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      number: map['number'] != null ? map['number'] as String : null,
      userID: map['userID'] != null ? map['userID'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, password: $password, number: $number, userID: $userID)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.password == password &&
        other.number == number &&
        other.userID == userID;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        password.hashCode ^
        number.hashCode ^
        userID.hashCode;
  }
}
