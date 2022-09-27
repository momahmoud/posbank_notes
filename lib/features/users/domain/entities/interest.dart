import 'package:equatable/equatable.dart';

class Interest extends Equatable {
  final String interestText;
  final String id;

  const Interest({
    required this.id,
    required this.interestText,
  });
  @override
  List<Object?> get props => [
        id,
        interestText,
      ];
}
