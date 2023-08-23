import 'package:canoa_v3_frontend/models/search_song.dart';
import 'package:canoa_v3_frontend/show_song_screen.dart';
import 'package:flutter/material.dart';
import 'package:canoa_v3_frontend/api.dart';
import 'dart:async';
import 'models/song.dart';

class ListSongsScreen extends StatefulWidget {
  const ListSongsScreen({Key? key}) : super(key: key);

  @override
  State<ListSongsScreen> createState() => _ListSongsScreenState();
}

class _ListSongsScreenState extends State<ListSongsScreen> {
  String dropdownValue = "Most Recent";
  Future<List<SearchSong>> futureSongs = API().fetchAvailableSongs();

  var items = [
    "Alphabetically",
    "Most Recent",
    "Oldest"
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(
        "Scoutify",
        style: TextStyle(
          fontSize: 28,
        ),
      ),
//      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: MySearchDelegate(),
              );
            },
            icon: Icon(Icons.search),
        ),
        PopupMenuButton(
          icon: const Icon(Icons.filter_alt),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: items[0],
              child: Text(items[0]),
            ),
            PopupMenuItem(
              value: items[1],
              child: Text(items[1]),
            ),
            PopupMenuItem(
              value: items[2],
              child: Text(items[2]),
            ),
          ],
          initialValue: dropdownValue,
          onSelected: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
        ),
      ],
    ),
    body: Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: FutureBuilder<List<SearchSong>>(
                  future: futureSongs,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<SearchSong> songs = sortSongs(snapshot.data!, dropdownValue);
                      return buildSongs(songs);
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  List<SearchSong> sortSongs(List<SearchSong> list, String sortBy) {
    List<SearchSong> res = list;
    if (sortBy == "Oldest") {
      res.sort((a, b) => a.id.compareTo(b.id));
    }
    else if (sortBy == "Most Recent") {
      res.sort((a, b) => (a.id*-1).compareTo(b.id*-1));
    }
    else if (sortBy == "Alphabetically") {
      res.sort((a, b) => a.title.compareTo(b.title));
    }
    return res;
  }

}

class MySearchDelegate extends SearchDelegate {

//  List<SearchSong> searchResults = await API().fetchAvailableSongs();
  List<String> searchResults = [
    "uma sugestao",
    "e outra",
    "mais uma",
    "e já chega",
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null); // close search bar
          } else {
            query = '';
          }
        },
        icon: Icon(Icons.clear)
    )];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        return close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(
        query,
        style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

  List<String> suggestions = searchResults.where((searchResult) {
    final result = searchResult.toLowerCase();
    final input = query.toLowerCase();

    return result.contains(input);
  }).toList();
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return ListTile(
            title: Text(suggestion),
            onTap: () {
              query = suggestion;

              showResults(context);
            },
          );
        }
    );
  }
}


Widget buildSongs(List<SearchSong> songs) => ListView.builder(
  itemCount: songs.length,
  scrollDirection: Axis.vertical,
  shrinkWrap: true,
  itemBuilder: (context, index) {
    final song = songs[index];
    return GestureDetector(
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Text(
                song.title,
                style: const TextStyle(
                    fontSize: 18
                ),
              ),
              padding: const EdgeInsets.all(15),
            ),
          ],
        ),
        color: Colors.white,
        margin: EdgeInsets.all(2),
        elevation: 0,
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ShowSongScreen(songId: song.id, songTitle: song.title)
            )
        );
      },
    );
  },
);

