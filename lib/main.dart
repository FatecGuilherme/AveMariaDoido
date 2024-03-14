import 'package:brincadeira/models/playlist_provider.dart';
import 'package:brincadeira/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';

void main() => runApp(
        // MyApp()
        // change provider
        // ChangeNotifierProvider(
        //     create: (context) => ThemeProvider(), child: const MyApp())
        MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(create: (context) => PlayListProvider()),
    ], child: const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
