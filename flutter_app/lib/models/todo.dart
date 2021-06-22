class Todo {
  int id;
  final String title;
  final String description;
  bool status;

  Todo(
      {required this.id,
      required this.title,
      required this.description,
      required this.status});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
    );
  }

  dynamic toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'status': status,
      };
}
