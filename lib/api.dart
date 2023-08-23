import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:canoa_v3_frontend/models/search_song.dart';
import 'package:http/http.dart' as http;
import 'package:canoa_v3_frontend/models/song.dart';
class API {
  /// local dev environment
  // static final String _url = "http://127.0.0.1:5000/api=";
  /// dev environment
  static final String _url = "http://192.168.1.88:5000/api=";

  Future<List<SearchSong>> fetchAvailableSongs() async {
      print(_url + "get_available_songs");
      var response = await http.get(Uri.parse(_url + "get_available_songs"));
      var body = json.decode(response.body);
      var res = body["data"].map<SearchSong>(SearchSong.fromJson).toList();
      return res;
  }

  Future<Song> fetchSongByID(int songID) async {
    print(_url + "get_song_by_id");
    print("id: " + songID.toString());

    var response = await http.post(
      Uri.parse(_url + "get_song_by_id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': songID,
      }),
    );

    var body = json.decode(response.body);
    var res = Song.fromJson(json.decode(body["data"]));

    print(res.lyrics);
    return res;
  }
}