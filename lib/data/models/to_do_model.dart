class ToDoModel {
  final String id;
  final String title;
  final bool date; // String for date
  final String time; // String for time
  final bool isCompleted;
  final int rate;

  ToDoModel({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.isCompleted,
    required this.rate,
  });

  // Named constructor to create a ToDoModel from a JSON map
  factory ToDoModel.fromJson(Map<String, dynamic> json) {
    return ToDoModel(
      id: json['id'],
      title: json['title'],
      date: json['date'], // Parse date as String
      time: json['time'], // Parse time as String
      isCompleted: json['isCompleted'],
      rate: json['rate'],
    );
  }

  // Method to convert a ToDoModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date, // Convert date to String
      'time': time, // Convert time to String
      'isCompleted': isCompleted,
      'rate': rate,
    };
  }
}
