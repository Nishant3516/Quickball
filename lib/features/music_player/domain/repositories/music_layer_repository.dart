import '../entities/music_player.dart';

abstract class MusicPlayerRepository {
  Future<void> playMusic();
  Future<void> pauseMusic();
  Future<void> nextSong();
  Future<void> previousSong();
  Future<void> changeVolume(double volume);
  Future<MusicPlayer> getCurrentMusicPlayer();
}
