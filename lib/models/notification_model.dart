class Notification {
  final String id;
  final String userId;
  final String message;
  final bool isViewed;
  final DateTime date;

  Notification({
    required this.id,
    required this.userId,
    required this.message,
    required this.isViewed,
    required this.date,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['_id'],
      userId: json['userId'],
      message: json['message'],
      isViewed: json['isViewed'],
      date: DateTime.parse(json['date']),
    );
  }
}
