import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_ball/features/assistive_ball/presentation/widgets/floating_widget.dart';
import 'package:quick_ball/features/todo/data/datasources/todo_local_datasource.dart';
import 'package:quick_ball/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:quick_ball/features/todo/domain/usecases/todo_usecase.dart';
import 'package:quick_ball/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:win32/win32.dart';
import 'package:window_manager/window_manager.dart';

void makeWindowTransparent(int hwnd) {
  // Get the current window style
  final extendedStyle =
      GetWindowLongPtr(hwnd, WINDOW_LONG_PTR_INDEX.GWL_EXSTYLE);

  // Set the extended window style to support layered windows and transparency
  SetWindowLongPtr(hwnd, WINDOW_LONG_PTR_INDEX.GWL_EXSTYLE,
      extendedStyle | WINDOW_EX_STYLE.WS_EX_LAYERED);

  // Set the window transparency to fully transparent
  SetLayeredWindowAttributes(
      hwnd, 0, 0, LAYERED_WINDOW_ATTRIBUTES_FLAGS.LWA_COLORKEY);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  final todoLocalDatasource = TodoLocalDatasourceImpl(sharedPreferences);
  final todoRepository = TodoRepositoryImpl(todoLocalDatasource);

  final getTodosUseCase = GetTodosUseCase(todoRepository);
  final addTodoUseCase = AddTodoUseCase(todoRepository);
  final updateTodoUseCase = UpdateTodoUseCase(todoRepository);
  final deleteTodoUseCase = DeleteTodoUseCase(todoRepository);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodoBloc(
            getTodosUseCase: getTodosUseCase,
            addTodoUseCase: addTodoUseCase,
            updateTodoUseCase: updateTodoUseCase,
            deleteTodoUseCase: deleteTodoUseCase,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );

  // Configure the window manager
  windowManager.waitUntilReadyToShow().then((_) async {
    final hwnd = GetForegroundWindow();

    await windowManager.setAsFrameless();
    await windowManager.setAlwaysOnTop(true);
    makeWindowTransparent(hwnd);
    await windowManager.setMinimizable(false);
  });

  doWhenWindowReady(() {
    const initialSize = Size(700, 700);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.topRight;
    appWindow.title = "";
    appWindow.show();
  });

  windowManager.restore();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.transparent,
      home: Opacity(
        opacity: 1,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          body: FloatingWidget(),
        ),
      ),
    );
  }
}
