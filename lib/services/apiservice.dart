import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_goals/tasks/model/task.dart';

class APIService {
  static const String tasks_url =
      'https://rizvan-todo-api.herokuapp.com/api/task_list';
  static const String delete_url =
      'https://rizvan-todo-api.herokuapp.com/api/task_delete/';
  static const String update_url =
      'https://rizvan-todo-api.herokuapp.com/api/task_update/';
  static const String create_url =
      'https://rizvan-todo-api.herokuapp.com/api/task_create';

  static var client = http.Client();

  static Future<List<Task>> getTasks() async {
    try {
      final response = await client.get(Uri.parse(tasks_url));
      if (response.statusCode == 200) {
        final List<Task> tasks = TaskFromJson(response.body);
        return tasks;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<Task> createTask(Map<String, dynamic> request) async {
    try {
      final response = await client.post(Uri.parse(create_url),
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
    String url = delete_url + id;
    try {
      final response =
          await client.delete(Uri.parse(url), headers: <String, String>{
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
    String url = update_url + id;
    try {
      final response = await client.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(request));
      if (response.statusCode == 200) {
        Task task = Task.fromJson(json.decode(response.body));
        return task;
      } else {
        print('Something went wrong. Error');
        return null;
      }
    } catch (e) {
      print('Something went wrong. Exception' + e.toString());
      return null;
    }
  }
}
