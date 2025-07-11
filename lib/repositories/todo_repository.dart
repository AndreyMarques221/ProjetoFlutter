import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist/models/todo.dart';

const toDoKey = 'todo_list';

class TodoRepository {
  late SharedPreferences sharedPreferences;

  TodoRepository._create();

  static Future<TodoRepository> create() async {
    var component = TodoRepository._create();
    component.sharedPreferences = await SharedPreferences.getInstance();
    return component;
  }

  Future<List<ToDo>> getTodoList() async {
    final String jsonString = sharedPreferences.getString(toDoKey) ?? '[]';
    final List jsonDecoded = json.decode(jsonString) as List;
    return jsonDecoded.map((e) => ToDo.fromJson(e)).toList();
  }

  void saveToDoList(List<ToDo> todos) {
    final String jsonString = json.encode(todos);
    sharedPreferences.setString(toDoKey, jsonString);
  }
}
