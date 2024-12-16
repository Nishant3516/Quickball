// lib/presentation/bloc/floating_widget_bloc.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'floating_widget_event.dart';
import 'floating_widget_state.dart';

class FloatingWidgetBloc
    extends Bloc<FloatingWidgetEvent, FloatingWidgetState> {
  FloatingWidgetBloc()
      : super(const FloatingWidgetState(
          position: Offset(100, 100), // Initial position
          isMenuExpanded: false, // Menu collapsed by default
        )) {
    on<DragWidgetEvent>((event, emit) {
      emit(state.copyWith(position: event.newPosition));
    });

    on<ToggleMenuEvent>((event, emit) {
      emit(state.copyWith(isMenuExpanded: event.isExpanded));
    });
  }
}
