// lib/app/presentation/widgets/music_player_controls.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_ball/features/music_player/presentation/bloc/music_player_bloc.dart';
import 'package:quick_ball/features/music_player/presentation/bloc/music_player_event.dart';

class MusicPlayerControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            context.read<MusicPlayerBloc>().add(PlayMusic());
          },
          child: Text('Play'),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<MusicPlayerBloc>().add(PauseMusic());
          },
          child: Text('Pause'),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<MusicPlayerBloc>().add(NextSong());
          },
          child: Text('Next'),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<MusicPlayerBloc>().add(PreviousSong());
          },
          child: Text('Previous'),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<MusicPlayerBloc>().add(ChangeVolume(0.1));
          },
          child: Text('Volume Up'),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<MusicPlayerBloc>().add(ChangeVolume(-0.1));
          },
          child: Text('Volume Down'),
        ),
      ],
    );
  }
}
