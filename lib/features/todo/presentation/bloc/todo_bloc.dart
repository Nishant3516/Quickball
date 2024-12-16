import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_ball/core/errors/failures.dart';
import 'package:quick_ball/features/todo/domain/entities/todo.dart';
import 'package:quick_ball/features/todo/domain/usecases/todo_usecase.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodosUseCase getTodosUseCase;
  final AddTodoUseCase addTodoUseCase;
  final UpdateTodoUseCase updateTodoUseCase;
  final DeleteTodoUseCase deleteTodoUseCase;

  TodoBloc({
    required this.getTodosUseCase,
    required this.addTodoUseCase,
    required this.updateTodoUseCase,
    required this.deleteTodoUseCase,
  }) : super(TodoInitialState()) {
    on<LoadTodosEvent>(_onLoadTodos);
    on<AddTodoEvent>(_onAddTodo);
    on<UpdateTodoEvent>(_onUpdateTodo);
    on<DeleteTodoEvent>(_onDeleteTodo);
  }

  Future<void> _onLoadTodos(
      LoadTodosEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoadingState());
    final result = await getTodosUseCase();
    result.fold(
      (failure) => emit(TodoErrorState(failure)),
      (todos) => emit(TodoLoadedState(todos)),
    );
  }

  Future<void> _onAddTodo(AddTodoEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoadingState());
    final result = await addTodoUseCase(event.todo);
    await result.fold(
      (failure) async {
        emit(TodoErrorState(failure));
      },
      (_) async {
        final todosResult = await getTodosUseCase();
        await todosResult.fold(
          (failure) async {
            emit(TodoErrorState(failure));
          },
          (todos) async {
            emit(TodoLoadedState(todos));
          },
        );
      },
    );
  }

  Future<void> _onUpdateTodo(
      UpdateTodoEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoadingState());
    final result = await updateTodoUseCase(event.id, event.todo);
    await result.fold(
      (failure) async {
        emit(TodoErrorState(failure));
      },
      (_) async {
        final todosResult = await getTodosUseCase();
        await todosResult.fold(
          (failure) async {
            emit(TodoErrorState(failure));
          },
          (todos) async {
            emit(TodoLoadedState(todos));
          },
        );
      },
    );
  }

  Future<void> _onDeleteTodo(
      DeleteTodoEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoadingState());
    final result = await deleteTodoUseCase(event.id);
    await result.fold(
      (failure) async {
        emit(TodoErrorState(failure));
      },
      (_) async {
        final todosResult = await getTodosUseCase();
        await todosResult.fold(
          (failure) async {
            emit(TodoErrorState(failure));
          },
          (todos) async {
            emit(TodoLoadedState(todos));
          },
        );
      },
    );
  }
}
