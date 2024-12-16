// lib/presentation/bloc/floating_widget_state.dart
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class FloatingWidgetState extends Equatable {
  final Offset position;
  final bool isMenuExpanded;

  const FloatingWidgetState({
    required this.position,
    required this.isMenuExpanded,
  });

  FloatingWidgetState copyWith({
    Offset? position,
    bool? isMenuExpanded,
  }) {
    return FloatingWidgetState(
      position: position ?? this.position,
      isMenuExpanded: isMenuExpanded ?? this.isMenuExpanded,
    );
  }

  @override
  List<Object?> get props => [position, isMenuExpanded];
}
