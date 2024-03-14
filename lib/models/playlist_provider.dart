import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:brincadeira/models/song.dart';
import 'package:flutter/material.dart';

class PlayListProvider extends ChangeNotifier {
  final List<Song> _playList = [
    Song(
        albumArtImagePath: 'assets/images/album_artwork_1.jpg',
        audioPath: '/audio/believer.mp3',
        artistName: 'Imagine Dragons',
        songName: 'Believer'),
    Song(
        albumArtImagePath: 'assets/images/album_artwork_1.jpg',
        audioPath: '/audio/believer.mp3',
        artistName: 'Luisão dos Cria',
        songName: 'Audio 2'),
    Song(
        albumArtImagePath: 'assets/images/album_artwork_1 copy.jpg',
        audioPath: 'assets/audio/believer.mp3',
        artistName: 'Luisão dos Cria',
        songName: 'Audio 3'),
  ];

  int? _currentSongIndex;

  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;
  PlayListProvider() {
    listenToDuration();
  }

  bool _isPlaying = false;



  void play() async {
    final String path = _playList[_currentSongIndex!].audioPath;
 
    await _audioPlayer.stop();
    print( AssetSource(path) );
    await _audioPlayer.play(await AssetSource(path));
      _isPlaying = true;
    notifyListeners();
    
   

    // // Play clip 2-4 seconds followed by clip 10-12 seconds
    // await player.setClip(start: Duration(seconds: 2), end: Duration(seconds: 4));
    // await player.play(); await player.pause();
    // await player.setClip(start: Duration(seconds: 10), end: Duration(seconds: 12));
    // await player.play(); await player.pause();

    // await player.setClip(); // Clear clip region
    // await player.setLoopMode(LoopMode.all);        // Set playlist to loop (off|all|one)
    // await player.setShuffleModeEnabled(true);      // Shuffle playlist order (true|false)

  }

  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playList.length - 1) {
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        currentSongIndex = 0;
      }
    }
  }

  void playPreviusSong() async {
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        currentSongIndex = _playList.length - 1;
      }
    }
  }

  void listenToDuration() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
      notifyListeners();
    });
  }

  List<Song> get playlist => _playList;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;
    if (newIndex != null) {
      play();
    }
    notifyListeners();
  }
}
