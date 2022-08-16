import 'dart:io';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_browser/widgets/notimplemented.dart';

class GuineaVideoPlayer extends StatefulWidget {
  const GuineaVideoPlayer(
      {Key? key,
      required this.url,
      this.controls = true,
      this.width = 640,
      this.height = 360})
      : super(key: key);

  final String url;
  final int width;
  final int height;
  final bool controls;

  @override
  State<GuineaVideoPlayer> createState() => _GuineaVideoPlayerState();
}

final Player player = Player(
  id: 1000,
  registerTexture: !Platform.isWindows,
);

class _GuineaVideoPlayerState extends State<GuineaVideoPlayer> {
  @override
  void initState() {
    super.initState();
    player.videoDimensions = VideoDimensions(widget.width, widget.height);
    if (mounted) {
      try {
        player.open(
          Media.network(widget.url),
          autoStart: false,
        );
      } catch (e) {
        debugPrint("Error loading audio source: $e");
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    //player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const GuineaNotImplementedWidget(
      body: "Video DOES NOT WORK YET. It results in a crash.",
    );
    // return Platform.isWindows
    //     ? NativeVideo(
    //         player: player,
    //         width: widget.width.toDouble(),
    //         height: widget.height.toDouble(),
    //         volumeThumbColor: Colors.blue,
    //         volumeActiveColor: Colors.blue,
    //         showControls: widget.controls,
    //       )
    //     : Video(
    //         player: player,
    //         width: widget.width.toDouble(),
    //         height: widget.height.toDouble(),
    //         volumeThumbColor: Colors.blue,
    //         volumeActiveColor: Colors.blue,
    //         showControls: widget.controls,
    //       );
  }
}
