class Song {
  final int id;
  final String title;
  final List lyrics;
//  final String chordsList;
  final List categories;
  final int creator_id;

  const Song({
    required this.id,
    required this.title,
    required this.lyrics,
 //   required this.chordsList,
    required this.categories,
    required this.creator_id
  });

  static Song fromJson(json) => Song(
      id: json["id"],
      title: json["title"],
      lyrics: json["lyrics"],
   //   chordsList: json["chordsList"],
      categories: json["categories"],
      creator_id: json["creator_id"]
  );
}