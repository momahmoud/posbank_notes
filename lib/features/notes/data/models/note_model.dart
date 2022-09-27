import 'package:pospank_notes/features/notes/domain/entities/note.dart';

class NoteModel extends Note {
  const NoteModel({
    required super.text,
    super.id,
    super.userId,
    required super.placeDateTime,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      text: json['text'],
      id: json['id'],
      userId: json['userId'] ?? null,
      placeDateTime: json['placeDateTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'userId': userId,
      'placeDateTime': placeDateTime,
    };
  }
}
