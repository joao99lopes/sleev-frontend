import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'api.dart';
import 'models/song.dart';

class ShowSongScreen extends StatefulWidget {
  final int songId;
  final String songTitle;
  const ShowSongScreen({Key? key, required this.songId, required this.songTitle}) : super(key: key);

  @override
  State<ShowSongScreen> createState() => _ShowSongScreenState();
}


class _ShowSongScreenState extends State<ShowSongScreen> {
  late Future<Song> futureSong;

  @override
  Widget build(BuildContext context) {
    futureSong = API().fetchSongByID(widget.songId);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Scoutify",
          style: TextStyle(
            fontSize: 28,
          ),
        ),
        automaticallyImplyLeading: true,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          Row(
//            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  widget.songTitle,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                ),
                padding: EdgeInsets.all(10),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    FutureBuilder<Song>(
                      future: futureSong,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          Song song = snapshot.data!;
                          return ListView.builder(
                            padding: EdgeInsets.all(10),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,                            itemCount: song.lyrics.length,
                            itemBuilder: (context, index) {
                              return Text(
                                song.lyrics[index],
                                style: TextStyle(
                                  fontSize: 20
                                ),
                              );
                            }
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ],

                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
