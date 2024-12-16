// lib/data/music_player_data_source_impl.dart

import 'package:flutter/services.dart';
import 'package:quick_ball/features/music_player/data/datasources/music_player_datasource.dart';
import '../models/music_player_model.dart';

class MusicPlayerDataSourceImpl implements MusicPlayerDataSource {
  static const MethodChannel _channel =
      MethodChannel('com.example/music_player');

  @override
  Future<void> playMusic() async {
    await _channel.invokeMethod('playMusic');
  }

  @override
  Future<void> pauseMusic() async {
    await _channel.invokeMethod('pauseMusic');
  }

  @override
  Future<void> nextSong() async {
    await _channel.invokeMethod('nextSong');
  }

  @override
  Future<void> previousSong() async {
    await _channel.invokeMethod('previousSong');
  }

  @override
  Future<void> changeVolume(double volume) async {
    await _channel.invokeMethod('changeVolume', {'volume': volume});
  }

  @override
  Future<MusicPlayerModel> getCurrentMusicPlayer() async {
    final Map<dynamic, dynamic> result =
        await _channel.invokeMethod('getCurrentMusicPlayer');
    return MusicPlayerModel.fromJson(Map<String, dynamic>.from(result));
  }
}
