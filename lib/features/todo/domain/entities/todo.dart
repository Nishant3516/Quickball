import 'package:quick_ball/features/todo/data/models/todo_model.dart';

class Todo {
  final String id;
  final String title;
  final String description;
  final String addedDate;
  final String completionDate;
  final bool isDone;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.addedDate,
    required this.completionDate,
    required this.isDone,
  });

  factory Todo.mapModelToEntity(TodoModel model) {
    return Todo(
      id: model.id,
      title: model.title,
      description: model.description,
      addedDate: model.addedDate,
      completionDate: model.completionDate,
      isDone: model.isDone,
    );
  }
}
