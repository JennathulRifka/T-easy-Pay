class Station {
  final String id;
  final String name;
  final String code;

  Station({required this.id, required this.name, required this.code});

  factory Station.fromMap(Map<String, dynamic> map, String id) {
    return Station(
      id: id,
      name: map['name'] ?? '',
      code: map['code'] ?? '',
    );
  }
}
