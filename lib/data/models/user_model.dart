import 'package:uuid/uuid.dart';

class UserModel {
  final String? id;
  final String firstName;
  final String lastName;
  final String email;
  final String gender;

  UserModel({
    String? id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'gender': gender,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      gender: map['gender'],
    );
  }
  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? gender,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      gender: gender ?? this.gender,
    );
  }
}
