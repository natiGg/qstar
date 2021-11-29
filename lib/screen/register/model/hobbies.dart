class Hobbies {
  int id;
  String name;

  Hobbies({required this.id, required this.name});
  factory Hobbies.fromJson(Map<String, dynamic> json) {
    return Hobbies(id: json["id"] as int, name: json["value"].toString());
  }
}
