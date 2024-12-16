// lib/presentation/bloc/floating_widget_event.dart
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class FloatingWidgetEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DragWidgetEvent extends FloatingWidgetEvent {
  final Offset newPosition;
  DragWidgetEvent(this.newPosition);

  @override
  List<Object?> get props => [newPosition];
}

class ToggleMenuEvent extends FloatingWidgetEvent {
  final bool isExpanded;
  ToggleMenuEvent(this.isExpanded);

  @override
  List<Object?> get props => [isExpanded];
}
