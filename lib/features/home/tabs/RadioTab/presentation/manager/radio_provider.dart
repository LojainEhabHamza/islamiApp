import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class RadioProvider with ChangeNotifier {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String? currentPlayingUrl;
  Map<String, bool> isPlayingMap = {};
  Map<String, bool> isVolumeUpMap = {};

  Future<void> play(String url) async {
    if (currentPlayingUrl == url && isPlaying) {
      await audioPlayer.pause();
      isPlaying = false;
    } else {
      if (currentPlayingUrl != null) {
        await audioPlayer.stop();
      }
      await audioPlayer.play(UrlSource(url));
      currentPlayingUrl = url;
      isPlaying = true;
      isPlayingMap[url] = true;
    }
    notifyListeners();
  }

  Future<void> stop() async {
    await audioPlayer.stop();
    isPlaying = false;
    currentPlayingUrl = null;
    notifyListeners();
  }

  Future<void> setVolume(String url, bool isVolumeUp) async {
    isVolumeUpMap[url] = isVolumeUp;
    if (currentPlayingUrl == url) {
      await audioPlayer.setVolume(isVolumeUp ? 2.0 : 0.0);
    }
    notifyListeners();
  }

  bool getVolumeStatus(String url) {
    return isVolumeUpMap[url] ?? true;
  }
}