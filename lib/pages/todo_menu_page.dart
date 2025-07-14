// ARQUIVO: TodoMenuPage.dart (ESTILIZADO)

import 'package:flutter/material.dart';
import 'package:todolist/pages/todo_list_page.dart';

class TodoMenuPage extends StatelessWidget {
  const TodoMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Menu Principal'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.list_alt),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TodoListPage()),
                    );
                  },
                  label: const Text('Tarefas de Estudo'),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () {
                    // Adicione a navegação para a outra tela aqui quando a tiver
                  },
                  label: const Text('Tarefas Diárias'),
                ),
              ],
            ),
          ),
        ));
  }
}