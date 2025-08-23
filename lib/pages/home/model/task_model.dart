class TaskModel {
  late int id;
  late String title;
  late bool isDone;
  late DateTime date;

  TaskModel({
    required this.id,
    required this.title,
    this.isDone = false,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isDone': isDone,
      'date': date.toIso8601String(),
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      isDone: json['isDone'],
      date: DateTime.parse(json['date']),
    );
  }
}
