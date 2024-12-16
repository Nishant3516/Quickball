// lib/app/blocs/music_player/music_player_event.dart

import 'package:equatable/equatable.dart';

abstract class MusicPlayerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlayMusic extends MusicPlayerEvent {}

class PauseMusic extends MusicPlayerEvent {}

class NextSong extends MusicPlayerEvent {}

class PreviousSong extends MusicPlayerEvent {}

class ChangeVolume extends MusicPlayerEvent {
  final double volume;

  ChangeVolume(this.volume);

  @override
  List<Object?> get props => [volume];
}

class LoadMusicPlayer extends MusicPlayerEvent {}
