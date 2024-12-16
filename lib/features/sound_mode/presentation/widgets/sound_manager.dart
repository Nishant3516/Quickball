import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';

class SoundManager extends StatefulWidget {
  const SoundManager({super.key});

  @override
  State<SoundManager> createState() => _SoundManagerState();
}

class _SoundManagerState extends State<SoundManager> {
  double? currentVolume = 0.0;
  bool? isMute;

  @override
  void initState() {
    super.initState();
    _initVolume();
  }

  Future<void> _initVolume() async {
    currentVolume = await FlutterVolumeController.getVolume();
    setState(() {});
  }

  Future<void> _setVolume(double volume) async {
    await FlutterVolumeController.setVolume(volume);
    setState(() {
      currentVolume = volume;
    });
  }

  Future<void> _muteVolume() async {
    isMute = await FlutterVolumeController.getMute();
    await FlutterVolumeController.setMute(!(isMute ?? false));
    setState(() {
      isMute = !(isMute ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: _muteVolume,
              icon: Icon(
                isMute ?? false
                    ? Icons.volume_off_outlined
                    : currentVolume != 0
                        ? currentVolume! > 0.5
                            ? Icons.volume_up_outlined
                            : Icons.volume_down_outlined
                        : Icons.volume_off_outlined,
                color: Colors.grey[100],
              )),
          Slider(
            value: currentVolume ?? 0,
            min: 0.0,
            max: 1.0,
            onChanged: (value) {
              isMute ?? false ? _setVolume(0) : _setVolume(value);
            },
          ),
          Text(
            currentVolume == 0
                ? '0'
                : (currentVolume! * 100).toInt().toString(),
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[100]),
          )
        ],
      ),
    );
  }
}
