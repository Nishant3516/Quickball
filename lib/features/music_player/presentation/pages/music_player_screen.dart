// lib/app/presentation/screens/music_player_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_ball/features/music_player/presentation/bloc/music_player_bloc.dart';
import 'package:quick_ball/features/music_player/presentation/bloc/music_player_state.dart';
import 'package:quick_ball/features/music_player/presentation/widgets/music_player_controls.dart';

class MusicPlayerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Player'),
      ),
      body: BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state.errorMessage != null) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                state.musicPlayer?.music ?? 'No song playing',
                style: TextStyle(fontSize: 24),
              ),
              MusicPlayerControls(),
            ],
          );
        },
      ),
    );
  }
}
