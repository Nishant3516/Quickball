// lib/app/domain/usecases/control_music_usecase.dart

import 'package:quick_ball/features/music_player/domain/repositories/music_layer_repository.dart';
import '../entities/music_player.dart';

class ControlMusicUseCase {
  final MusicPlayerRepository repository;

  ControlMusicUseCase(this.repository);

  Future<void> executePlay() async {
    await repository.playMusic();
  }

  Future<void> executePause() async {
    await repository.pauseMusic();
  }

  Future<void> executeNext() async {
    await repository.nextSong();
  }

  Future<void> executePrevious() async {
    await repository.previousSong();
  }

  Future<void> executeChangeVolume(double volume) async {
    await repository.changeVolume(volume);
  }

  Future<MusicPlayer> getCurrentMusicPlayer() async {
    return await repository.getCurrentMusicPlayer();
  }
}
