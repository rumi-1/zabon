import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

/// Plays bundled assets (same paths as in [pubspec] `flutter.assets`).
class SimpleAudioPlayer extends StatefulWidget {
  const SimpleAudioPlayer({
    super.key,
    required this.audioAssetPath,
  });

  /// e.g. `assets/audio/sample_listen.mp3`
  final String audioAssetPath;

  @override
  State<SimpleAudioPlayer> createState() => _SimpleAudioPlayerState();
}

class _SimpleAudioPlayerState extends State<SimpleAudioPlayer> {
  late AudioPlayer _player;
  bool _playing = false;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _player.onPlayerComplete.listen((_) {
      if (mounted) setState(() => _playing = false);
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  String _assetKey() {
    var p = widget.audioAssetPath;
    if (p.startsWith('assets/')) {
      p = p.substring('assets/'.length);
    }
    return p;
  }

  Future<void> _toggle() async {
    if (_playing) {
      await _player.pause();
      setState(() => _playing = false);
    } else {
      await _player.stop();
      await _player.play(AssetSource(_assetKey()));
      setState(() => _playing = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 44,
      color: Theme.of(context).colorScheme.primary,
      icon: Icon(
        _playing ? Icons.pause_circle_filled : Icons.play_circle_fill,
      ),
      onPressed: _toggle,
    );
  }
}
