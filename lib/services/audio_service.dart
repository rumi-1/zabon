import 'package:audioplayers/audioplayers.dart';

class AudioService {
  AudioService._();

  static final AudioService instance = AudioService._();

  final AudioPlayer _player = AudioPlayer();

  Future<void> playAlphabetSound(String fileName) async {
    await _player.stop();
    await _player.play(AssetSource('audio/alphabet/$fileName'));
  }

  Future<void> dispose() async {
    await _player.dispose();
  }
}