import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist/models/todo.dart';

const toDoKey = 'todo_list';

class TodoRepository {
  late SharedPreferences sharedPreferences;

  Future<List<ToDo>> getTodoList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString(toDoKey) ?? '[]';
    final List jsonDecoded = json.decode(jsonString) as List;
    return jsonDecoded.map((e) => ToDo.fromJson(e)).toList();
  }

  void saveToDoList(List<ToDo> todos) {
    final String jsonString = json.encode(todos);
    sharedPreferences.setString(toDoKey, jsonString);
  }
}
