import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dart_vlc/dart_vlc.dart';

class GuineaAudio extends StatefulWidget {
  const GuineaAudio({Key? key, this.url, this.width = 640, this.height = 360})
      : super(key: key);

  final String? url;
  final int width;
  final int height;

  @override
  State<GuineaAudio> createState() => _GuineaAudioState();
}

class _GuineaAudioState extends State<GuineaAudio> {
  late Player _player;
  bool playing = false;
  int currentPosition = 0;
  int currentDuration = 0;

  Future<void> _init() async {
    _player = Player(
      id: 0,
      videoDimensions: VideoDimensions(widget.width, widget.height),
      registerTexture: !Platform.isWindows,
    );
    if (widget.url == null) {
      return;
    }
    _player.errorStream.listen((event) {
      debugPrint('libvlc error $event');
    });
    try {
      _player.open(
        Media.network(widget.url!),
        autoStart: false,
      );
    } catch (e) {
      debugPrint("Error loading audio source: $e");
    }
    _player.positionStream.listen((PositionState state) {
      setState(() {
        currentPosition = state.position!.inSeconds;
        currentDuration = state.duration!.inSeconds;
      });
    });
    _player.playbackStream.listen((PlaybackState state) {
      setState(() {
        playing = state.isPlaying;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    //ambiguate(WidgetsBinding.instance)!.addObserver(this);
    _init();
  }

  @override
  void dispose() {
    super.dispose();
    _player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      width: 300,
      height: 40,
      child: Center(
        child: Row(
          children: [
            IconButton(
              iconSize: 20,
              splashRadius: 15,
              icon: Icon(
                playing ? Icons.pause : Icons.play_arrow,
              ),
              onPressed: () {
                if (_player.playback.isCompleted) {
                  _player.previous();
                  _player.play();
                } else {
                  _player.playOrPause();
                }
              },
            ),
            Slider(
              value: currentPosition.toDouble(),
              max: currentDuration.toDouble(),
              label:
                  "${Duration(seconds: currentPosition).inHours == 0 ? '' : '${Duration(seconds: currentPosition).inHours}:'}${Duration(seconds: currentPosition).inMinutes == 0 ? '' : '${Duration(seconds: currentPosition).inMinutes}:'}${Duration(seconds: currentPosition).inSeconds == 0 ? '' : '${Duration(seconds: currentPosition).inSeconds}:'}",
              onChanged: (double value) {
                _player.seek(Duration(seconds: value.toInt()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
