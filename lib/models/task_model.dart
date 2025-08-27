class Task {
  final int id;
  final String title;
  final String? description;
  final String? priority;
  final int categoryId;
  final String? dueDate;
  final bool completed;
  final String? imageUrl;
  final String createdAt;
  final String updatedAt;

  Task({
    required this.id,
    required this.title,
    this.description,
    this.priority,
    required this.categoryId,
    this.dueDate,
    required this.completed,
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      priority: json['priority'],
      categoryId: json['category_id'],
      dueDate: json['due_date'],
      completed: json['completed'],
      imageUrl: json['image_url'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'priority': priority,
    'category_id': categoryId,
    'due_date': dueDate,
    'completed': completed,
    'image_url': imageUrl,
  };
}
