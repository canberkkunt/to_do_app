class TaskModel {
  late int id;
  late String title;
  late bool isDone;

  TaskModel({required this.id, required this.title, this.isDone = false});

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'isDone': isDone};
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      isDone: json['isDone'],
    );
  }
}
