import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String username;
  final String id;
  final String email;
  final String? imageAsBase64;
  final String interestId;
  final String password;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.interestId,
    required this.password,
    this.imageAsBase64,
  });
  @override
  List<Object?> get props =>
      [id, username, email, interestId, imageAsBase64, password];
}








// {
// "text": "Asd",
// "placeDateTime": "2022-09-26T10:41:08.041",
// "userId": "1",
// "id": "0"
// },