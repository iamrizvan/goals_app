import 'dart:convert';
import 'package:my_goals/models/task.dart';
import 'package:http/http.dart' as http;

class WebService {
  static const String url =
      'https://rizvan-todo-api.herokuapp.com/api/task_list';
  static const String delete_task =
      'https://rizvan-todo-api.herokuapp.com/api/task_delete/';
  static const String update_task =
      'https://rizvan-todo-api.herokuapp.com/api/task_update/';
  static const String create_task =
      'https://rizvan-todo-api.herokuapp.com/api/task_create';

  static Future<List<Task>> getTasks() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<Task> tasks = TaskFromJson(response.body);
        return tasks;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  static Future<Task> createTask(Map<String, dynamic> request) async {
    try {
      final response = await http.post(create_task,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            
          },
          body: jsonEncode(request));

      if (response.statusCode == 200) {
        return Task.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<String> deleteTask(String id) async {
    String url = delete_task + id;
    try {
      final response = await http.delete(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
      if (response.statusCode == 200) {
        String result = response.body;
        return result;
      } else {
        return 'Deletion failed!';
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<Task> updateTask(
      Map<String, dynamic> request, String id) async {
    String url = update_task + id;
    try {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(request));

      if (response.statusCode == 200) {
        Task task = Task.fromJson(json.decode(response.body));
        return task;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
