import 'package:flutter/material.dart';
import 'package:todolist/models/todo.dart';
import 'package:todolist/widgets/todo_list_widget.dart';

class TodoListPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<ToDo> toDos = [];
  ToDo? undo;
  int? undoIndex;
  final TextEditingController toDoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Icon(Icons.arrow_back), title: Text('Estuda Fácil'), backgroundColor: const Color.fromARGB(255, 60, 131, 189)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              addTarefa(),
              SizedBox(height: 8),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    // ignore: unused_local_variable
                    for (ToDo task in toDos) TodoListWidget(task: task, onDelete: _onDelete),
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
        Text('Você possui ${toDos.length} tarefas pendentes.', style: TextStyle(fontSize: 13.5)),
        ElevatedButton(onPressed: confirmationDelete, style: ElevatedButton.styleFrom(padding: EdgeInsets.all(8)), child: Text('Limpar Tudo')),
      ],
    );
  }

  //functions
  void _onSubmitted(String text) {
    if (text == '' || text == ' ') {
      return;
    }
    setState(() {
      ToDo newtoDo = ToDo(title: text, date: DateTime.now());
      toDos.add(newtoDo);
    });
    toDoController.clear();
  }

  void _onDelete(ToDo toDo) {
    setState(() {
      undo = toDo;
      undoIndex = toDos.indexOf(toDo);
      toDos.remove(toDo);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${toDo.title} removido com sucesso!'),
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () {
            setState(() {
              toDos.insert(undoIndex!, undo!);
            });
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  void confirmationDelete() {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text('Limpar Tudo?'),
      content: Text('Você tem certeza que deseja apagar todas as tarefas?'),
      actions: [
        TextButton(
          onPressed: (){
            Navigator.of(context).pop();
          }, 
          style: TextButton.styleFrom(backgroundColor: Colors.blue),
          child: Text('Cancelar',style: TextStyle(color: Colors.white)),
        ),
        TextButton(
          onPressed: (){
            setState(() {
              toDos.clear();
              Navigator.of(context).pop();
            });
          },
          style: TextButton.styleFrom(backgroundColor: Colors.red), 
          child: Text('Limpar Tudo', style: TextStyle(color: Colors.white))),
      ],
    ));
  }
}
