// ARQUIVO: TodoListWidget.dart (ESTILIZADO)

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todolist/models/todo.dart';

class TodoListWidget extends StatelessWidget {
  const TodoListWidget({
    super.key,
    required this.task,
    required this.onDelete,
    required this.onEdit,
  });

  final ToDo task;
  final Function(ToDo) onDelete;
  final Function(ToDo) onEdit;

  @override
  Widget build(BuildContext context) {
    // Usando Card para um visual mais limpo e com elevação
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Slidable(
        closeOnScroll: true,
        endActionPane: ActionPane(
          motion: const BehindMotion(), // BehindMotion tem um efeito mais suave
          extentRatio: 0.4,
          children: [
            SlidableAction(
              padding: EdgeInsets.symmetric(horizontal: 0),
              onPressed: (context) => onEdit(task),
              label: 'Editar',
              backgroundColor: Colors.blueAccent,
              icon: Icons.edit,
            ),
            SlidableAction(
              padding: EdgeInsets.symmetric(horizontal: 0),
              onPressed: (context) => onDelete(task),
              label: 'Deletar',
              backgroundColor: Colors.redAccent,
              icon: Icons.delete,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                DateFormat('dd/MM/yyyy - HH:mm').format(task.date),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Text(
                task.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}