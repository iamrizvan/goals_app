import 'dart:convert';

List<Task> TaskFromJson(String str) {
  return List<Task>.from(json.decode(str).map((x) {
    return Task.fromJson(x);
  }));
}

String TaskToJson(List<Task> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Task {
  int id;
  String title;
  String description;
  bool completed;
  String created_date;

  Task({this.id, this.title, this.description, this.completed, this.created_date});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json['id'], title: json['title'],description: json['description'], completed: json['completed'],created_date: json['created_date']);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "title": title, "description":description, "completed": completed, "created_date":created_date};
  }
}
