import 'dart:convert';
import 'package:quick_ball/features/todo/data/models/todo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class TodoLocalDatasource {
  Future<List<TodoModel>> getTodos();
  Future<void> addTodo(TodoModel todo);
  Future<void> updateTodo(String id, TodoModel todo);
  Future<void> deleteTodo(String id);
}

class TodoLocalDatasourceImpl extends TodoLocalDatasource {
  final SharedPreferences sharedPreferences;

  TodoLocalDatasourceImpl(this.sharedPreferences);

  @override
  Future<List<TodoModel>> getTodos() async {
    final todosJson = sharedPreferences.getStringList('todos') ?? [];
    return todosJson
        .map((json) => TodoModel.fromJson(jsonDecode(json)))
        .toList();
  }

  @override
  Future<void> addTodo(TodoModel todo) async {
    final todos = await getTodos();
    todos.add(todo);
    final todosJson = todos.map((todo) => jsonEncode(todo.toJson())).toList();
    await sharedPreferences.setStringList('todos', todosJson);
  }

  @override
  Future<void> updateTodo(String id, TodoModel updatedTodo) async {
    final todos = await getTodos();
    final index = todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      todos[index] = updatedTodo;
      final todosJson = todos.map((todo) => jsonEncode(todo.toJson())).toList();
      await sharedPreferences.setStringList('todos', todosJson);
    }
  }

  @override
  Future<void> deleteTodo(String id) async {
    final todos = await getTodos();
    todos.removeWhere((todo) => todo.id == id);
    final todosJson = todos.map((todo) => jsonEncode(todo.toJson())).toList();
    await sharedPreferences.setStringList('todos', todosJson);
  }
}
