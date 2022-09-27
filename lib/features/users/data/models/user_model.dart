import 'package:pospank_notes/features/notes/domain/entities/note.dart';
import 'package:pospank_notes/features/users/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.username,
    required super.email,
    required super.interestId,
    required super.password,
    super.imageAsBase64,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        imageAsBase64: json['imageAsBase64'] ?? null,
        id: json['id'],
        username: json['username'],
        email: json['email'],
        interestId: json['intrestId'],
        password: json['password']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageAsBase64': imageAsBase64,
      'username': username,
      'email': email,
      'intrestId': interestId,
    };
  }
}
