import 'package:flutter/material.dart';
import 'package:todolist/models/todo.dart';
import 'package:todolist/widgets/todo_list_widget.dart';
import 'package:todolist/repositories/todo_repository.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<ToDo> toDos = [];
  ToDo? undo;
  int? undoIndex;
  String? errorText;
  final TextEditingController toDoController = TextEditingController();
  final TodoRepository toDoRepository = TodoRepository();
  String? error;

  @override
  void initState() {
    super.initState();
    toDoRepository.getTodoList().then((value) {
      setState(() {
        toDos = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estuda Fácil'), actions: [IconButton(icon: const Icon(Icons.add), onPressed: _showAddTaskDialog, tooltip: 'Adicionar Tarefa')]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            Expanded(child: ListView(children: [for (ToDo task in toDos) TodoListWidget(task: task, onDelete: _onDelete, onEdit: _onEdit)])),
            const SizedBox(height: 16),
            bottomPart(),
          ],
        ),
      ),
    );
  }
  Row bottomPart() {
    return Row(
      children: [
        Expanded(child: Text('Você possui ${toDos.length} tarefas pendentes.', style: const TextStyle(fontSize: 14))),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: toDos.isEmpty ? null : confirmationDelete,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
          child: const Text('Limpar Tudo'),
        ),
      ],
    );
  }

  void _showAddTaskDialog() {
    // Limpa o texto de erro ao abrir o dialog
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text('Nova Tarefa'),
            content: TextField(
              controller: toDoController,
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'O que você precisa fazer?', 
                border: OutlineInputBorder(),
                ),
              onSubmitted: (text) {
                _onSubmitted(text);
                // Fecha o dialog apenas se o texto for válido
                if (text.trim().isNotEmpty) {
                  Navigator.of(context).pop();
                }
              },
            ),
            actions: [
              TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancelar')),
              TextButton(
                onPressed: () {
                  if (_onSubmitted(toDoController.text)) {
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
    );
  }
  bool _onSubmitted(String text) {
    if (text.isEmpty) {
      setState(() {
        error = "A tarefa não pode ser vazia!";
      });
      // Recria o dialog com o erro, sem fechar
      return false;
    } else {
      setState(() {
        ToDo newtoDo = ToDo(title: text, date: DateTime.now());
        toDos.add(newtoDo);
        error = null;
      });
      toDoController.clear();
      toDoRepository.saveToDoList(toDos);
      return true;
    }
  }

  void _onDelete(ToDo toDo) {
    final ToDo deletedToDo = toDo;
    final int deletedToDoIndex = toDos.indexOf(toDo);
    setState(() {
      toDos.remove(toDo);
    });
    toDoRepository.saveToDoList(toDos);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tarefa "${deletedToDo.title}" foi removida.'),
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () {
            setState(() {
              toDos.insert(deletedToDoIndex, deletedToDo);
            });
            toDoRepository.saveToDoList(toDos);
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    );
    toDoRepository?.saveToDoList(toDos);
  }
  void _onEdit(ToDo toDo) {
    final TextEditingController editController = TextEditingController(text: toDo.title);
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Editar Tarefa'),
            content: TextField(
              controller: editController,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Edite a Tarefa'),
              onSubmitted: (text) => _performEdit(toDo, text),
            ),
            actions: [
              TextButton(child: const Text('Cancelar'), onPressed: () => Navigator.of(context).pop()),
              TextButton(child: const Text('Salvar'), onPressed: () => _performEdit(toDo, editController.text)),
            ],
          ),
    );
  }

  void _performEdit(ToDo toDo, String newTitle) {
    if (newTitle.trim().isNotEmpty) {
      setState(() {
        toDo.title = newTitle;
      });
      toDoRepository.saveToDoList(toDos);
      Navigator.of(context).pop();
    }
  }

  void confirmationDelete() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Limpar Tudo?'),
            content: const Text('Você tem certeza que deseja apagar todas as tarefas?'),
            actions: [
              TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancelar')),
              TextButton(
                onPressed: () {
                  setState(() {
                    toDos.clear();
                  });
                  toDoRepository.saveToDoList(toDos);
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Limpar Tudo'),
              ),
            ],
          ),
    );
  }
}
