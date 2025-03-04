import 'package:dartz/dartz.dart';
import 'package:quick_ball/core/errors/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
