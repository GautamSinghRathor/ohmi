class Person {
  final int id;
  final String profileImage;
  final String name;
  final String known;

  Person({
    this.id,
    this.name,
    this.known,
    this.profileImage,
  });

  Person.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        known = json['known_for_department'],
        profileImage = json['profile_path'];
}
