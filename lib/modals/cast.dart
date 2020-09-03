class Cast {
  final int id;
  final String character;
  final String name;
  final String profilePath;

  Cast({
    this.id,
    this.character,
    this.name,
    this.profilePath,
  });

  Cast.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        character = json['character'],
        name = json['name'],
        profilePath = json['profile_path'];
}
