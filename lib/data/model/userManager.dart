import 'package:uuid/uuid.dart';

class UserManager {
  String id;
  String name;
  String email;
  String password;

  UserManager({
    String? id,
    required this.name,
    required this.email,
    required this.password,
  }) : id = id ?? const Uuid().v4();

  // Convert the object to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }

  // Create an object from a map
  factory UserManager.fromMap(Map<String, dynamic> map) {
    return UserManager(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
    );
  }
}
