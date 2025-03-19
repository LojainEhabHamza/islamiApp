import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class RadioProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String? currentPlayingUrl;
  Map<String, bool> isPlayingMap = {};
  Map<String, bool> isVolumeUpMap = {};

  Future<void> play(String url) async {
    if (currentPlayingUrl == url && isPlaying) {
      await _audioPlayer.pause();
      isPlaying = false;
    } else {
      if (currentPlayingUrl != null) {
        await _audioPlayer.stop();
      }
      await _audioPlayer.play(UrlSource(url));
      currentPlayingUrl = url;
      isPlaying = true;
      isPlayingMap[url] = true;
    }
    notifyListeners();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    isPlaying = false;
    currentPlayingUrl = null;
    notifyListeners();
  }

  Future<void> setVolume(String url, bool isVolumeUp) async {
    isVolumeUpMap[url] = isVolumeUp;
    await _audioPlayer.setVolume(isVolumeUp ? 1.0 : 0.0);
    notifyListeners();
  }

  bool getVolumeStatus(String url) {
    return isVolumeUpMap[url] ?? true;
  }
}