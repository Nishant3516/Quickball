import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_ball/features/todo/domain/entities/todo.dart';
import 'package:quick_ball/features/todo/presentation/bloc/todo_bloc.dart';

class TodoWidget extends StatelessWidget {
  const TodoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Text(
            'To-Do List',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [Shadow(blurRadius: 15, color: Colors.black)],
            ),
            textAlign: TextAlign.center,
          ),
        ),
        BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is TodoLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TodoErrorState) {
              return Center(child: Text('Error: ${state.failure}'));
            } else if (state is TodoLoadedState) {
              return SizedBox(
                height: 200,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.todos.length,
                  itemBuilder: (context, index) {
                    final todo = state.todos[index];
                    return GestureDetector(
                      onLongPress: () {
                        _showDeleteTodoDialog(context, todo.id);
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 16.0),
                        elevation: 4.0,
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      todo.title,
                                      style: TextStyle(
                                        fontSize: 14,
                                        decoration: todo.isDone
                                            ? TextDecoration.lineThrough
                                            : null,
                                      ),
                                    ),
                                    SizedBox(height: 4.0),
                                    Text(
                                      todo.description,
                                      style: TextStyle(
                                        fontSize: 12,
                                        decoration: todo.isDone
                                            ? TextDecoration.lineThrough
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                todo.isDone
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                                size: 20,
                              ),
                              onPressed: () {
                                BlocProvider.of<TodoBloc>(context).add(
                                  UpdateTodoEvent(
                                    todo.id,
                                    Todo(
                                      id: todo.id,
                                      title: todo.title,
                                      description: todo.description,
                                      addedDate: todo.addedDate,
                                      completionDate: DateTime.now().toString(),
                                      isDone: !todo.isDone,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return const Center(
                child: Text(
                  'No todos available.',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              _showAddTodoDialog(context);
            },
            child: Text('Add To-Do'),
          ),
        ),
      ],
    );
  }

  void _showAddTodoDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add To-Do'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final title = titleController.text;
                final description = descriptionController.text;

                if (title.isNotEmpty && description.isNotEmpty) {
                  BlocProvider.of<TodoBloc>(context).add(AddTodoEvent(
                    Todo(
                      id: UniqueKey().toString(),
                      title: title,
                      description: description,
                      addedDate: DateTime.now().toString(),
                      completionDate: DateTime.now().toString(),
                      isDone: false,
                    ),
                  ));
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteTodoDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete To-Do'),
          content: Text('Are you sure you want to delete this to-do?'),
          actions: [
            TextButton(
              onPressed: () {
                BlocProvider.of<TodoBloc>(context).add(DeleteTodoEvent(id));
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
