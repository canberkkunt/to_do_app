class NoteModel {
  int id;
  String content;

  NoteModel({required this.id, required this.content});

  Map<String, dynamic> toJson() {
    return {'id': id, 'content': content};
  }

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(id: json['id'], content: json['content']);
  }
}
