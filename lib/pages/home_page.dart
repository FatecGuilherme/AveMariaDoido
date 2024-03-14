import 'package:brincadeira/components/my_drawer.dart';
import 'package:brincadeira/models/playlist_provider.dart';
import 'package:brincadeira/models/song.dart';
import 'package:brincadeira/pages/song_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final dynamic playlistProvider;
  @override
  void initState() {
    super.initState();

    playlistProvider = Provider.of<PlayListProvider>(context, listen: false);
  }

  void goToSong(int songIndex) {
    playlistProvider.currentSongIndex = songIndex;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SongPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: const Text("P L A Y L I S T")),
      drawer: const MyDrawer(),
      body: Consumer<PlayListProvider>(builder: (context, value, child) {
        // get songs
        final List<Song> playlist = value.playlist;

        // make UI
        return ListView.builder(
          itemCount: playlist.length,
          itemBuilder: (context, index) {
            final Song song = playlist[index];

            return ListTile(
              title: Text(song.songName),
              subtitle: Text(song.artistName),
              leading: song.albumArtImagePath == ""
                  ? Icon(Icons.music_note_sharp)
                  : Image.asset(song.albumArtImagePath),
              onTap: () => goToSong(index),
            );
          },
        );
      }),
    );
  }
}
