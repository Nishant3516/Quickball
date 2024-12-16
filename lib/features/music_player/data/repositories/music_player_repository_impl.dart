// lib/app/data/repositories/music_player_repository_impl.dart

import 'package:quick_ball/features/music_player/data/datasources/music_player_datasource.dart';
import 'package:quick_ball/features/music_player/domain/repositories/music_layer_repository.dart';

import '../../domain/entities/music_player.dart';

class MusicPlayerRepositoryImpl implements MusicPlayerRepository {
  final MusicPlayerDataSource dataSource;

  MusicPlayerRepositoryImpl(this.dataSource);

  @override
  Future<void> playMusic() async {
    await dataSource.playMusic();
  }

  @override
  Future<void> pauseMusic() async {
    await dataSource.pauseMusic();
  }

  @override
  Future<void> nextSong() async {
    await dataSource.nextSong();
  }

  @override
  Future<void> previousSong() async {
    await dataSource.previousSong();
  }

  @override
  Future<void> changeVolume(double volume) async {
    await dataSource.changeVolume(volume);
  }

  @override
  Future<MusicPlayer> getCurrentMusicPlayer() async {
    final musicPlayerModel = await dataSource.getCurrentMusicPlayer();
    return musicPlayerModel;
  }
}
