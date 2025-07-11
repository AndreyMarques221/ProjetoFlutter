import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todolist/models/todo.dart';

class TodoListWidget extends StatelessWidget {
  const TodoListWidget({super.key, required this.task, required this.onDelete, required this.onEdit});
  final ToDo task;
  final Function(ToDo) onDelete;
  final Function(ToDo) onEdit;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Slidable(
        closeOnScroll: true,
        endActionPane: ActionPane(
          extentRatio: 0.3,
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              label: 'Delete',
              padding: EdgeInsets.symmetric(horizontal: 2),
              autoClose: true,
              onPressed: (context) {
                onDelete(task);
              },
              backgroundColor: Color(0xFFFE4A49),
              icon: Icons.delete,
            ),
            SlidableAction(
              onPressed: (context) {
                onEdit(task);
              },
              label: 'Edit',
              padding: EdgeInsets.symmetric(horizontal: 2),
              backgroundColor: Colors.blue,
              icon: Icons.edit,
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(3)),
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              Text(DateFormat('dd/MM/yyyy - HH:mm').format(task.date), style: TextStyle(fontSize: 12)),
              Text(task.title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
