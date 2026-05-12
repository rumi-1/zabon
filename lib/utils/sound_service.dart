import 'dart:math';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

/// Plays short synthesized tones for exercise feedback.
/// Generates PCM WAV bytes in memory — no audio assets needed.
class SoundService {
  SoundService._();
  static final SoundService instance = SoundService._();

  final AudioPlayer _player = AudioPlayer();
  bool enabled = true;

  Future<void> playCorrect() async {
    HapticFeedback.lightImpact();
    if (!enabled) return;
    await _play(_buildWav([
      _Tone(880, 0.08, 0.9),
      _Tone(1100, 0.10, 0.7),
    ]));
  }

  Future<void> playWrong() async {
    HapticFeedback.mediumImpact();
    if (!enabled) return;
    await _play(_buildWav([
      _Tone(300, 0.10, 0.8),
      _Tone(220, 0.14, 0.6),
    ]));
  }

  Future<void> playComplete() async {
    HapticFeedback.heavyImpact();
    if (!enabled) return;
    await _play(_buildWav([
      _Tone(523, 0.10, 0.7),
      _Tone(659, 0.10, 0.7),
      _Tone(784, 0.18, 0.9),
    ]));
  }

  Future<void> playTap() async {
    HapticFeedback.selectionClick();
    if (!enabled) return;
    await _play(_buildWav([_Tone(660, 0.05, 0.4)]));
  }

  Future<void> _play(Uint8List wav) async {
    try {
      await _player.play(BytesSource(wav));
    } catch (_) {}
  }

  static const int _sampleRate = 22050;

  static Uint8List _buildWav(List<_Tone> tones) {
    final segments = tones.map((t) => _generateSegment(t)).toList();
    final totalSamples = segments.fold<int>(0, (s, seg) => s + seg.length);

    final dataSize = totalSamples * 2;
    final buf = ByteData(44 + dataSize);

    // RIFF header
    _writeAscii(buf, 0, 'RIFF');
    buf.setUint32(4, 36 + dataSize, Endian.little);
    _writeAscii(buf, 8, 'WAVE');
    _writeAscii(buf, 12, 'fmt ');
    buf.setUint32(16, 16, Endian.little);
    buf.setUint16(20, 1, Endian.little); // PCM
    buf.setUint16(22, 1, Endian.little); // mono
    buf.setUint32(24, _sampleRate, Endian.little);
    buf.setUint32(28, _sampleRate * 2, Endian.little);
    buf.setUint16(32, 2, Endian.little);
    buf.setUint16(34, 16, Endian.little);
    _writeAscii(buf, 36, 'data');
    buf.setUint32(40, dataSize, Endian.little);

    int offset = 44;
    for (final seg in segments) {
      for (final sample in seg) {
        buf.setInt16(offset, sample, Endian.little);
        offset += 2;
      }
    }
    return buf.buffer.asUint8List();
  }

  static List<int> _generateSegment(_Tone tone) {
    final n = (_sampleRate * tone.duration).toInt();
    final out = List<int>.filled(n, 0);
    final attack = (n * 0.03).toInt();
    final releaseStart = (n * 0.65).toInt();

    for (var i = 0; i < n; i++) {
      double env;
      if (i < attack) {
        env = i / attack;
      } else if (i >= releaseStart) {
        env = (n - i) / (n - releaseStart).clamp(1, n);
      } else {
        env = 1.0;
      }
      final t = i / _sampleRate;
      final val = sin(2 * pi * tone.frequency * t) * env * tone.volume;
      out[i] = (val * 32767).round().clamp(-32768, 32767);
    }
    return out;
  }

  static void _writeAscii(ByteData buf, int offset, String s) {
    for (var i = 0; i < s.length; i++) {
      buf.setUint8(offset + i, s.codeUnitAt(i));
    }
  }
}

class _Tone {
  const _Tone(this.frequency, this.duration, this.volume);
  final double frequency;
  final double duration;
  final double volume;
}
