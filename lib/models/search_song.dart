class SearchSong {
  final int id;
  final String title;
  final List categories;

  const SearchSong({
    required this.id,
    required this.title,
    required this.categories,
  });

  static SearchSong fromJson(json) => SearchSong(
      id: json["id"],
      title: json["title"],
      categories: json["categories"],
  );
}