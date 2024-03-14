import 'package:brincadeira/pages/settings_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            // logo
            DrawerHeader(
                child: Center(
              child: Icon(Icons.music_note,
                  size: 40,
                  color: Theme.of(context).colorScheme.inversePrimary),
            )),

            //home tile
            Padding(
                padding: const EdgeInsets.only(left: 25.0, top: 25.0),
                child: ListTile(
                  title: const Text("H O M E"),
                  leading: const Icon(Icons.home),
                  onTap: () => Navigator.pop(context),
                )),

            // settings
            Padding(
                padding: const EdgeInsets.only(left: 25.0, top: 0),
                child: ListTile(
                  title: const Text("S E T T I N G S"),
                  leading: const Icon(Icons.settings),
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsPage(),
                        ));
                  },
                ))
          ],
        ));
  }
}