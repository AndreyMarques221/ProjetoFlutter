import 'package:flutter/material.dart';
import 'package:todolist/widgets/todo_list_widget.dart';

class TodoListPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  int tasks = 0;
  List<String> toDos = [];
  bool tOrF = false;
  final TextEditingController toDoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Icon(Icons.arrow_back), title: Text('Estuda Fácil'), backgroundColor: const Color.fromARGB(255, 60, 131, 189)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              addTarefa(),
              SizedBox(height: 15),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    // ignore: unused_local_variable
                    for (String toDo in toDos)
                      TodoListWidget(toDo : toDo),
                  ],
                ),
              ),
              bottomPart(),
            ],
          ),
        ),
      ),
    );
  }

  Row addTarefa() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: toDoController,
            decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Adicione uma Tarefa', hintText: 'Estudar'),
            onSubmitted: _onSubmitted,
          ),
        ),
        SizedBox(width: 20),
        ElevatedButton(
          onPressed: () {
            _onSubmitted(toDoController.text);
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.purple, padding: EdgeInsets.all(18), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
          child: Icon(Icons.add, color: Colors.black, size: 30),
        ),
      ],
    );
  }

  Row bottomPart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Você possui $tasks tarefas pendentes.', style: TextStyle(fontSize: 13.5)),
        ElevatedButton(
          onPressed: () {
            setState(() {
              toDos.clear();
              tasks = 0;
            });
          },
          style: ElevatedButton.styleFrom(padding: EdgeInsets.all(8)),
          child: Text('Limpar Tudo'),
        ),
      ],
    );
  }

  //functions
  void _onSubmitted(String text) {
    setState(() {
      toDos.add(text);
      tasks++;
    });
    toDoController.clear();
  }

  
}
