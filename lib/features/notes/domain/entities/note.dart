import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final String text;
  final String? id;
  final String? userId;
  final String placeDateTime;

  const Note({
    required this.text,
    required this.id,
    this.userId,
    required this.placeDateTime,
  });
  @override
  List<Object?> get props => [text, id, userId, placeDateTime];
}








// {
// "text": "Asd",
// "placeDateTime": "2022-09-26T10:41:08.041",
// "userId": "1",
// "id": "0"
// },