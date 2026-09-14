enum TaskStatus { pending, completed }

class Task {
  String title;
  String description;
  TaskStatus status;
  Task({required this.title, required this.description, required this.status});

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'status': status.name,
  };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    title: json['title'] as String,
    description: json['description'] as String,
    status: TaskStatus.values.byName(json['status'] as String),
  );
}
