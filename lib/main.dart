import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Color redAccent = Color(0xFFFF3B30);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radio App',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: redAccent,
        ),
        iconTheme: IconThemeData(color: redAccent),
      ),
      home: RadioPlayer(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RadioPlayer extends StatefulWidget {
  @override
  _RadioPlayerState createState() => _RadioPlayerState();
}

class _RadioPlayerState extends State<RadioPlayer> {
  late AudioPlayer _player;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _player.setUrl('https://stream.zeno.fm/cn78er2mewmtv');
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final redAccent = Color(0xFFFF3B30);

    return Scaffold(
      appBar: AppBar(title: Text('Radio Stream')),
      body: Center(
        child: StreamBuilder<PlayerState>(
          stream: _player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final playing = playerState?.playing ?? false;
            final processing = playerState?.processingState;

            if (processing == ProcessingState.loading || processing == ProcessingState.buffering) {
              return CircularProgressIndicator(color: redAccent);
            } else if (!playing) {
              return IconButton(
                icon: Icon(Icons.play_arrow),
                iconSize: 80,
                color: redAccent,
                onPressed: _player.play,
              );
            } else {
              return IconButton(
                icon: Icon(Icons.pause),
                iconSize: 80,
                color: redAccent,
                onPressed: _player.pause,
              );
            }
          },
        ),
      ),
    );
  }
}

