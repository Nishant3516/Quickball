// lib/app/blocs/music_player/music_player_state.dart

import 'package:equatable/equatable.dart';
import '../../domain/entities/music_player.dart';

class MusicPlayerState extends Equatable {
  final MusicPlayer? musicPlayer;
  final bool isLoading;
  final String? errorMessage;

  const MusicPlayerState({
    this.musicPlayer,
    this.isLoading = false,
    this.errorMessage,
  });

  MusicPlayerState copyWith({
    MusicPlayer? musicPlayer,
    bool? isLoading,
    String? errorMessage,
  }) {
    return MusicPlayerState(
      musicPlayer: musicPlayer ?? this.musicPlayer,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [musicPlayer, isLoading, errorMessage];
}
