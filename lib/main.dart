import 'package:aerobic_space/pages/loading_page.dart';
import 'package:aerobic_space/pages/main_page.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool loaded = false;

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Aerobic.Space',
    theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.indigo)),
    home: loaded
        ? MainPage()
        : LoadingPage(
            future: Future.delayed(Duration(seconds: 2)),
            onFinish: () => setState(() => loaded = true),
          ),
  );
}

void main() => runApp(const App());
