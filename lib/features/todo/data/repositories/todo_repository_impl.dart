import 'package:dartz/dartz.dart';
import 'package:quick_ball/core/errors/failures.dart';
import 'package:quick_ball/features/todo/data/datasources/todo_local_datasource.dart';
import 'package:quick_ball/features/todo/data/models/todo_model.dart';
import 'package:quick_ball/features/todo/domain/entities/todo.dart';
import 'package:quick_ball/features/todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDatasource localDataSource;
  TodoRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<Todo>>> getTodos() async {
    try {
      final todoModels = await localDataSource.getTodos();
      final todos =
          todoModels.map((model) => Todo.mapModelToEntity(model)).toList();
      return Right(todos);
    } catch (e) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addTodo(Todo todo) async {
    try {
      final todoModel = TodoModel.mapEntityToModel(todo);
      await localDataSource.addTodo(todoModel);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateTodo(String id, Todo todo) async {
    try {
      final todoModel = TodoModel.mapEntityToModel(todo);

      await localDataSource.updateTodo(id, todoModel);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteTodo(String id) async {
    try {
      await localDataSource.deleteTodo(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure());
    }
  }
}
