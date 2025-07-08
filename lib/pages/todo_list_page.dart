import 'package:flutter/material.dart';

class TodoListPage extends StatelessWidget {
  TodoListPage({super.key});
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: emailController, 
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                   labelText: 'Email'
                   ),
                onChanged: onChanged,
             ),
              ElevatedButton(onPressed: login, child: Text('Entrar')),
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    String email;
    email = emailController.text;
    // ignore: avoid_print
    print(email);
    emailController.clear();
  }
  void onChanged(String text){
    print(text);
  }
}

