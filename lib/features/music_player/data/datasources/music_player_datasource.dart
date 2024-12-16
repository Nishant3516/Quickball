import '../models/music_player_model.dart';

abstract class MusicPlayerDataSource {
  Future<void> playMusic();
  Future<void> pauseMusic();
  Future<void> nextSong();
  Future<void> previousSong();
  Future<void> changeVolume(double volume);
  Future<MusicPlayerModel> getCurrentMusicPlayer();
}
