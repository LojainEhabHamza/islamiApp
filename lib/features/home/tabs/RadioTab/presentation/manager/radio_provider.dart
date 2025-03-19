import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class RadioProvider with ChangeNotifier {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String? currentPlayingUrl;
  Map<String, bool> isPlayingMap = {};
  Map<String, bool> isVolumeUpMap = {};
  Map<String, double> previousVolumeMap = {};

  RadioProvider() {
    audioPlayer.setVolume(1.0);
  }

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

      if (!isVolumeUpMap.containsKey(url)) {
        isVolumeUpMap[url] = true;
        previousVolumeMap[url] = 1.0;
        await audioPlayer.setVolume(1.0);
      }
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
      if (isVolumeUp) {
        // عند unmute، نعيد الصوت إلى القيمة السابقة
        double restoredVolume = previousVolumeMap[url] ?? 1.0;
        await audioPlayer.setVolume(restoredVolume);
      } else {
        // عند mute، نحفظ القيمة الحالية للصوت ونضبطه على 0.0
        previousVolumeMap[url] = audioPlayer.volume; // حفظ قيمة الصوت الحالية
        await audioPlayer.setVolume(0.0);
      }
    }

    notifyListeners();
  }

  bool getVolumeStatus(String url) {
    return isVolumeUpMap[url] ?? true; // القيمة الافتراضية هي true (الصوت يعمل)
  }
}