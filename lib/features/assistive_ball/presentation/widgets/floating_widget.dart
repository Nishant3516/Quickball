import 'dart:math';
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:quick_ball/features/scribble/presentation/pages/scribbler_appd.dart';
import 'package:quick_ball/features/sound_mode/presentation/widgets/sound_manager.dart';
import 'package:quick_ball/features/todo/presentation/widgets/todo_widget.dart';

class FloatingWidget extends StatefulWidget {
  const FloatingWidget({super.key});

  @override
  State<FloatingWidget> createState() => _FloatingWidgetState();
}

class _FloatingWidgetState extends State<FloatingWidget> {
  bool isMenuVisible = false;
  bool isScribbling = false;
  bool isMusicPlayerVisible = false;
  bool isTodoPopupVisible = false;
  bool isSoundPopupVisible = false;
  bool isScribblePopupVisible = false;
  Offset _popupPosition = Offset.zero;
  final GlobalKey _todoIconKey = GlobalKey();
  final GlobalKey _soundIconKey = GlobalKey();
  final GlobalKey _scribbleIconKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        appWindow.startDragging();
      },
      onTap: () {
        setState(() {
          isMenuVisible = !isMenuVisible;
        });
      },
      child: Stack(
        children: [
          // Central Button
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 35,
            top: MediaQuery.of(context).size.height / 2 - 35,
            child: CircleAvatar(
              radius: isMenuVisible ? 30 : 35,
              backgroundColor: Colors.deepPurpleAccent,
              child: const Icon(
                Icons.apps,
                color: Colors.white,
              ),
            ),
          ),
          if (isMenuVisible) ..._buildMenuOptions(),

          if (isScribblePopupVisible)
            Positioned(
              left: _popupPosition.dx,
              top: _popupPosition.dy,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: Colors.deepPurpleAccent),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.lightBlueAccent[400],
                ),
                width: 280,
                height: 1000,
                child: ScribblerApp(),
              ),
            ),
          if (isSoundPopupVisible)
            Positioned(
              left: _popupPosition.dx,
              top: _popupPosition.dy,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: Colors.deepPurpleAccent),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.lightBlueAccent[400],
                ),
                width: 280,
                height: 80,
                child: const SoundManager(),
              ),
            ),
          if (isTodoPopupVisible)
            Positioned(
              left: _popupPosition.dx,
              top: _popupPosition.dy,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: Colors.deepPurpleAccent),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.lightBlueAccent[400],
                ),
                width: 200,
                height: 300,
                child: const TodoWidget(),
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> _buildMenuOptions() {
    const double radius = 75;

    final List<Widget> menuItems = [];
    final options = [
      {'icon': Icons.checklist, 'label': 'To-Do', 'key': _todoIconKey},
      {'icon': Icons.volume_up, 'label': 'Sound', 'key': _soundIconKey},
      {'icon': Icons.done, 'label': 'Clipboard'},
      {'icon': Icons.currency_bitcoin, 'label': 'Screenshot'},
      {'icon': Icons.edit, 'label': 'Scribble', 'key': _scribbleIconKey},
      {'icon': Icons.music_note, 'label': 'Music'},
    ];

    final int menuItemCount = options.length;
    final double angleStep = 2 * pi / menuItemCount;

    for (int i = 0; i < menuItemCount; i++) {
      final double angle = i * angleStep;
      final double x = radius * cos(angle);
      final double y = radius * sin(angle);

      menuItems.add(
        Positioned(
          left: MediaQuery.of(context).size.width / 2 - 30 + x,
          top: MediaQuery.of(context).size.height / 2 - 30 + y,
          child: GestureDetector(
            key: options[i].containsKey('key')
                ? options[i]['key'] as GlobalKey
                : null,
            onTap: () {
              if (options[i]['label'] == 'Music') {
                setState(() {
                  isMusicPlayerVisible = !isMusicPlayerVisible;
                });
              } else if (options[i]['label'] == 'Sound') {
                setState(() {
                  if (isSoundPopupVisible) {
                    isSoundPopupVisible = false;
                  } else {
                    final soundIconRenderBox = _soundIconKey.currentContext
                        ?.findRenderObject() as RenderBox?;
                    if (soundIconRenderBox != null) {
                      final position =
                          soundIconRenderBox.localToGlobal(Offset.zero);
                      _popupPosition = position + const Offset(30, 30);
                      isSoundPopupVisible = true;
                    }
                  }
                });
              } else if (options[i]['label'] == 'Scribble') {
                setState(() {
                  if (isScribblePopupVisible) {
                    isScribblePopupVisible = false;
                  } else {
                    final scribbleIconRenderBox =
                        _scribbleIconKey.currentContext?.findRenderObject()
                            as RenderBox?;
                    if (scribbleIconRenderBox != null) {
                      final position =
                          scribbleIconRenderBox.localToGlobal(Offset.zero);
                      _popupPosition = position + const Offset(30, 30);
                      isScribblePopupVisible = true;
                    }
                  }
                });
              } else if (options[i]['label'] == 'To-Do') {
                setState(() {
                  if (isTodoPopupVisible) {
                    isTodoPopupVisible = false;
                  } else {
                    final todoIconRenderBox = _todoIconKey.currentContext
                        ?.findRenderObject() as RenderBox?;
                    if (todoIconRenderBox != null) {
                      final position =
                          todoIconRenderBox.localToGlobal(Offset.zero);
                      _popupPosition = position + const Offset(30, 30);
                      isTodoPopupVisible = true;
                    }
                  }
                });
              }
            },
            child: Center(
              child: _buildMenuOption(
                options[i]['icon'] as IconData,
                options[i]['label'] as String,
              ),
            ),
          ),
        ),
      );
    }
    return menuItems;
  }

  Widget _buildMenuOption(IconData icon, String label) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Colors.orangeAccent,
      child: Icon(icon, color: Colors.black),
    );
  }
}
