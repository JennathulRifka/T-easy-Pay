class Train {
  String id;
  String from;
  String to;
  String trainName;
  String trainNo;
  String trainType;
  List<String> days;
  String departure;
  String arrival;
  String duration;
  String status;
  List<String> classes; // Changed from String to List<String>
  String  available;
  bool isUpdated;
  
  Train({
    required this.id,
    required this.from,
    required this.to,
    required this.trainNo,
    required this.trainName,
    required this.trainType,
    required this.days,
    required this.departure,
    required this.arrival,
    required this.duration,
    required this.available,
    required this.classes,
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
    
    List<String> classList = [];
    if (json['classes'] != null) {
      classList = List<String>.from(json['classes']);
    } else if (json['class'] != null) {
      classList = [json['class'] as String];
    }
    
    return Train(
      id: documentId,
      from: json['from'] ?? '',
      to: json['to'] ?? '',
      trainName: json['trainName'] ?? '',
      trainNo: json['trainNo'] ?? '',
      trainType: json['trainType'] ?? '',
      days: daysList,
      departure: json['departure'] ?? '',
      arrival: json['arrival'] ?? '',
      duration: json['duration'] ?? '',
      available: json['available'] ?? '',
      classes: classList,
      status: json['status'] ?? '',
      isUpdated: json['isUpdated'] as bool? ?? false,
    );
  }
  
  
  // Helper method to check if train is available on a specific day
  bool isAvailableOnDay(String day) {
    return days.contains(day);
  }
  
  // Helper method to check if train has a specific class
  bool hasClass(String className) {
    return classes.contains(className);
  }


}



