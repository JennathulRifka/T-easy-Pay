class Train {
  String trainId;
  String number;
  String name;
  String type;
  String departureTime;
  String arrivalTime;
  String startingCode;
  String endingCode;
  List<String> stations;
  String start;
  String end;
  String departureStation;
  String arrivalStation;

  Train({
    required this.trainId,
    required this.number,
    required this.name,
    required this.type,
    required this.startingCode,
    required this.departureTime,
    required this.arrivalTime,
    required this.endingCode,
    required this.stations,
    required this.start,
    required this.end,
    required this.departureStation,
    required this.arrivalStation,
  });

  factory Train.fromJson(Map<String, dynamic> json, String id) {
    return Train(
      trainId: id,
      number: json['number'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      startingCode: json['startingCode'] ?? '',
      departureTime: json['departureTime'] ?? '',
      arrivalTime: json['arrivalTime'] ?? '',
      endingCode: json['endingCode'] ?? '',
      stations: List<String>.from(json['stations'] ?? []),
      start: json['start'] ?? '',
      end: json['end'] ?? '',
      departureStation: json['departureStation'] ?? '',
      arrivalStation: json['arrivalStation'] ?? '',
    );
  }
}
