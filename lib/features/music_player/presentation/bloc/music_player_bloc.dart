// lib/app/blocs/music_player/music_player_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_ball/features/music_player/domain/usecases/contol_music_usecase.dart';

import 'music_player_event.dart';
import 'music_player_state.dart';

class MusicPlayerBloc extends Bloc<MusicPlayerEvent, MusicPlayerState> {
  final ControlMusicUseCase controlMusicUseCase;

  MusicPlayerBloc(this.controlMusicUseCase) : super(MusicPlayerState());

  @override
  Stream<MusicPlayerState> mapEventToState(MusicPlayerEvent event) async* {
    if (event is LoadMusicPlayer) {
      yield state.copyWith(isLoading: true);
      try {
        final musicPlayer = await controlMusicUseCase.getCurrentMusicPlayer();
        yield state.copyWith(
          musicPlayer: musicPlayer,
          isLoading: false,
        );
      } catch (e) {
        yield state.copyWith(
          isLoading: false,
          errorMessage: e.toString(),
        );
      }
    } else if (event is PlayMusic) {
      await controlMusicUseCase.executePlay();
    } else if (event is PauseMusic) {
      await controlMusicUseCase.executePause();
    } else if (event is NextSong) {
      await controlMusicUseCase.executeNext();
    } else if (event is PreviousSong) {
      await controlMusicUseCase.executePrevious();
    } else if (event is ChangeVolume) {
      await controlMusicUseCase.executeChangeVolume(event.volume);
    }
    add(LoadMusicPlayer()); // Refresh state after action
  }
}
