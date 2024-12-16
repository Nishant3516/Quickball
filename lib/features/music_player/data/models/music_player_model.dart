// lib/app/data/models/music_player_model.dart

import '../../domain/entities/music_player.dart';

class MusicPlayerModel extends MusicPlayer {
  MusicPlayerModel({
    String? music,
    required bool isPlaying,
    required double volume,
  }) : super(music: music, isPlaying: isPlaying, volume: volume);

  factory MusicPlayerModel.fromJson(Map<String, dynamic> json) {
    return MusicPlayerModel(
      music: json['music'],
      isPlaying: json['isPlaying'],
      volume: json['volume'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'music': music,
      'isPlaying': isPlaying,
      'volume': volume,
    };
  }
}
