import 'package:pospank_notes/features/users/domain/entities/interest.dart';

class InterestModel extends Interest {
  InterestModel({
    required super.id,
    required super.interestText,
  });

  factory InterestModel.fromJson(Map<String, dynamic> json) {
    return InterestModel(
      id: json['id'],
      interestText: json['intrestText'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'intrestText': interestText,
    };
  }
}
