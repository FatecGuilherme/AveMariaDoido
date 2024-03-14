import 'package:brincadeira/components/neu_box.dart';
import 'package:brincadeira/models/playlist_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  String formatTime(Duration duration) {
    String twoDigitSecond =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedTime = "${duration.inMinutes}:$twoDigitSecond";
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayListProvider>(
      builder: (context, value, child) {
        // get playlist
        final playlist = value.playlist;
        // get current song index;
        final currentSong = playlist[value.currentSongIndex ?? 0];

        // return Scaffold UI.
        return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: SafeArea(
                child: Padding(
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, bottom: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // appbar
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(Icons.arrow_back)),
                            const Text("P L A Y L I S T"),
                            IconButton(
                                onPressed: () {}, icon: const Icon(Icons.menu)),
                          ],
                        ),

                        const SizedBox(
                          height: 25,
                        ),

                        // album artwork
                        NeuBox(
                            child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(currentSong.albumArtImagePath),
                            ),

                            // song and artist name
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // song and artist name
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(currentSong.songName,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          )),
                                      Text(currentSong.artistName),
                                    ],
                                  ),

                                  // heart icon
                                  const Icon(Icons.favorite, color: Colors.red)
                                ],
                              ),
                            )
                          ],
                        )),

                        const SizedBox(
                          height: 25,
                        ),

                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // start time
                                    Text(formatTime(value.currentDuration)),

                                    // shuffle icon
                                    Icon(Icons.shuffle),

                                    // repeat icon
                                    Icon(Icons.repeat),

                                    // end time
                                    Text(formatTime(value.totalDuration)),
                                  ],
                                ),

                                // song duration progress
                                SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                        thumbShape: const RoundSliderThumbShape(
                                            enabledThumbRadius: 0)),
                                    child: Slider(
                                      value: value.currentDuration.inSeconds
                                          .toDouble(),
                                      min: 0,
                                      max: value.totalDuration.inSeconds
                                          .toDouble(),
                                      activeColor: Colors.green,
                                      onChanged: (double double) {},
                                      onChangeEnd: (double double) {
                                        value.seek(
                                            Duration(seconds: double.toInt()));
                                      },
                                    ))
                              ],
                            )),

                        const SizedBox(
                          height: 25,
                        ),

                        // playback controls
                        Row(
                          children: [
                            // skip previus
                            Expanded(
                                child: GestureDetector(
                              child: NeuBox(child: Icon(Icons.skip_previous)),
                              onTap: value.playPreviusSong,
                            )),

                            const SizedBox(
                              width: 25,
                            ),
                            // play / pause
                            Expanded(
                                child: GestureDetector(
                              child: NeuBox(
                                  child: Icon(value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow)),
                              onTap: value.pauseOrResume,
                            )),

                            const SizedBox(
                              width: 25,
                            ),

                            // skip forward
                            Expanded(
                                child: GestureDetector(
                              onTap: value.playNextSong,
                              child: NeuBox(child: Icon(Icons.skip_next)),
                            )),
                          ],
                        )
                      ],
                    ))));
      },
    );
  }
}
