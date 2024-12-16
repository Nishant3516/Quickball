import 'package:equatable/equatable.dart';

// Base Failure class
abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {}

class DatabaseFailure extends Failure {}

class AuthFailure extends Failure {}

class GeneralFailure extends Failure {
  final String message;
  GeneralFailure(this.message);

  @override
  List<Object?> get props => [message];
}
