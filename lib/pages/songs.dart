import 'package:flutter/material.dart';

class SongsPage extends StatefulWidget {
  final List<String> songs;
  const SongsPage({super.key, required this.songs});

  @override
  State<SongsPage> createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recommended Songs'),
      ),
      body: ListView.builder(
        itemCount: widget.songs.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(widget.songs[index]),
          );
        },
      ),
    );
  }
}
