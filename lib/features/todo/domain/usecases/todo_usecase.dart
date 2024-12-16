import 'package:dartz/dartz.dart';
import 'package:quick_ball/core/errors/failures.dart';
import 'package:quick_ball/features/todo/domain/entities/todo.dart';
import 'package:quick_ball/features/todo/domain/repositories/todo_repository.dart';

class GetTodosUseCase {
  final TodoRepository repository;

  GetTodosUseCase(this.repository);

  Future<Either<Failure, List<Todo>>> call() {
    return repository.getTodos();
  }
}

class AddTodoUseCase {
  final TodoRepository repository;

  AddTodoUseCase(this.repository);

  Future<Either<Failure, void>> call(Todo todo) {
    return repository.addTodo(todo);
  }
}

class UpdateTodoUseCase {
  final TodoRepository repository;

  UpdateTodoUseCase(this.repository);

  Future<Either<Failure, void>> call(String id, Todo todo) {
    return repository.updateTodo(id, todo);
  }
}

class DeleteTodoUseCase {
  final TodoRepository repository;

  DeleteTodoUseCase(this.repository);

  Future<Either<Failure, void>> call(String id) {
    return repository.deleteTodo(id);
  }
}
