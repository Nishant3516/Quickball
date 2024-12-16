import 'package:dartz/dartz.dart';
import 'package:quick_ball/core/errors/failures.dart';
import 'package:quick_ball/features/todo/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<Todo>>> getTodos();
  Future<Either<Failure, void>> addTodo(Todo todo);
  Future<Either<Failure, void>> updateTodo(String id, Todo todo);
  Future<Either<Failure, void>> deleteTodo(String id);
}
