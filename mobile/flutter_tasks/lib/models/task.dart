class Task {
  final int? id;
  String title;
  bool done;
  int? userId;
  DateTime? createdAt;

  Task({
    this.id,
    required this.title,
    this.done = false,
    this.userId,
    this.createdAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as int?,
      title: json['title'] ?? '',
      done: json['done'] ?? false,
      userId: json['userId'] as int?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'done': done,
      if (userId != null) 'userId': userId,
    };
  }
}
