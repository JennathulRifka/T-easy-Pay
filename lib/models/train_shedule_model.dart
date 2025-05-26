
class Train {
  String id;
  String from;
  String to;
  String trainName;
  String type;
  List<String> days;
  String departure;
  String arrival;
  String duration;
  String status;
  bool isUpdated;

  Train({
    required this.id,
    required this.from,
    required this.to,
    required this.trainName,
    required this.type,
    required this.days,
    required this.departure,
    required this.arrival,
    required this.duration,
    required this.status,
    required this.isUpdated,
  });

  // Factory method to convert Firebase document (JSON) into a Dart object
  factory Train.fromJson(Map<String, dynamic> json, String documentId) {


    // Handle both 'days' (array) and 'day' (single string) cases
    List<String> daysList = [];
    if (json['days'] != null) {
      daysList = List<String>.from(json['days']);
    } else if (json['day'] != null) {
      daysList = [json['day'] as String];
    }

    return Train(
      id: documentId,
      from: json['from'] ?? '',
      to: json['to'] ?? '',
      trainName: json['trainName'] ?? '',
      type: json['type'] ?? '',
      days: daysList,
      departure: json['departure'] ?? '',
      arrival: json['arrival'] ?? '',
      duration: json['duration'] ?? '',
      status: json['status'] ?? '',
      isUpdated: json['isUpdated'] as bool? ?? false,
    );
  }
    // Helper method to check if train is available on a specific day
      bool isAvailableOnDay(String day) {
        return days.contains(day);
      }
}
