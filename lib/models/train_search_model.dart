class TrainSearchModel {
  final String fromStation;
  final String toStation;
  final DateTime departureDate;

  TrainSearchModel({
    required this.fromStation,
    required this.toStation,
    required this.departureDate,
  });

  // Optional: For easier route navigation (GoRouter extra)
  Map<String, dynamic> toMap() {
    return {
      'fromStation': fromStation,
      'toStation': toStation,
      'departureDate': departureDate.toIso8601String(),
    };
  }

  factory TrainSearchModel.fromMap(Map<String, dynamic> map) {
    return TrainSearchModel(
      fromStation: map['fromStation'] ?? '',
      toStation: map['toStation'] ?? '',
      departureDate: DateTime.parse(map['departureDate']),
    );
  }
}
