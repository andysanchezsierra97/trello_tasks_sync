class Task {
  final String userId;
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isCompleted;

  Task(
      {required this.userId,
      required this.id,
      required this.title,
      required this.description,
      required this.createdAt,
      required this.updatedAt,
      required this.isCompleted});
}
