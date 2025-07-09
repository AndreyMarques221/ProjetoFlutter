import 'package:flutter/material.dart';

class TodoListWidget extends StatelessWidget {
  const TodoListWidget({super.key, required this.toDo});
  final String toDo;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
        ),
      padding : EdgeInsets.all(16),
      child: Column( 
        crossAxisAlignment: CrossAxisAlignment.start,

        children : [
          Text(_date(), style : TextStyle(fontSize: 12)),
          Text(toDo, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
          SizedBox(height: 20),
        ]
      ),
    );
  }
  String _date() {
    String date = '';
    date += DateTime.now().day.toString().padLeft(2, '0');
    date += '/';
    date += DateTime.now().month.toString().padLeft(2, '0');
    date += '/';
    date += DateTime.now().year.toString().padLeft(2, '0');
    date += ' - ';
    date += DateTime.now().hour.toString().padLeft(2, '0');
    date += ':';
    date += DateTime.now().minute.toString().padLeft(2, '0');
    date += ':';
    date += DateTime.now().second.toString().padLeft(2, '0');
    return date;
  }
}