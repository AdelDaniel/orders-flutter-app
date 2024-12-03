import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  const Failure({
    this.langKey,
    this.message,
    this.details,
  });

  final String? message;
  final String? details;
  final String? langKey;

  @override
  List<Object?> get props => [message, details, langKey];
}
