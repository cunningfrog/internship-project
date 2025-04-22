class Task {
  final String? id;
  final String title;
  final bool isCompleted;
  final DateTime createdAt;
  final String? userId;

  Task({
    this.id,
    required this.title,
    this.isCompleted = false,
    DateTime? createdAt,
    this.userId,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id']?.toString(),
      title: json['title'] ?? '',
      isCompleted: json['is_completed'] ?? false,
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
      userId: json['user_id']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'is_completed': isCompleted,
      'created_at': createdAt.toIso8601String(),
      if (userId != null) 'user_id': userId,
    };
  }

  Task copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    DateTime? createdAt,
    String? userId,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
    );
  }

  @override
  String toString() {
    return 'Task{id: $id, title: $title, isCompleted: $isCompleted, createdAt: $createdAt, userId: $userId}';
  }
}
