///
class Exercise {
  final int id;
  final String? iconPath;
  final String name;
  final String description;
  final String category;

  ///
  Exercise(
      {required this.id,
      this.iconPath,
      required this.name,
      required this.description,
      required this.category});

  ///
  factory Exercise.fromJson(final Map<String, dynamic> map) {
    return Exercise(
        id: map["id"],
        iconPath: map["iconPath"],
        name: map["name"],
        description: map["description"],
        category: map["category"]);
  }

  ///
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "iconPath": iconPath,
      "name": name,
      "description": description,
      "category": category,
    };
  }
}
