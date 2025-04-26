class Fruit {
  final int id;
  final String name;
  final bool seedless;

  Fruit({required this.id, required this.name, required this.seedless});

  factory Fruit.fromJson(Map<String, dynamic> json) {
    return Fruit(
      id: json['id'],
      name: json['name'],
      seedless: json['seedless'] == 1 ? true : false,
    );
  }
}
