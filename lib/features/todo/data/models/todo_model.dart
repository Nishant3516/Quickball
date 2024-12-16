import 'package:quick_ball/features/todo/domain/entities/todo.dart';

class TodoModel extends Todo {
  TodoModel({
    required String id,
    required String title,
    required String description,
    required String addedDate,
    required String completionDate,
    required bool isDone,
  }) : super(
          id: id,
          title: title,
          description: description,
          addedDate: addedDate,
          completionDate: completionDate,
          isDone: isDone,
        );

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      addedDate: json['addedDate'] as String,
      completionDate: json['completionDate'] as String,
      isDone: json['isDone'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'addedDate': addedDate,
      'completionDate': completionDate,
      'isDone': isDone,
    };
  }

  factory TodoModel.mapEntityToModel(Todo entity) {
    return TodoModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      addedDate: entity.addedDate,
      completionDate: entity.completionDate,
      isDone: entity.isDone,
    );
  }
}
