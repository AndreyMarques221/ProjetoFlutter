import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todolist/pages/todo_menu_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Definindo uma paleta de cores coesa
    const primaryColor = Color(0xFF0D47A1); // Um azul escuro e profissional
    const accentColor = Color(0xFF42A5F5); // Um azul mais vibrante para ações
    const backgroundColor = Color(0xFFF5F5F5); // Um fundo cinza claro, suave para os olhos
    const cardColor = Colors.white;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Estuda Fácil',
      // Aplicando o tema central para todo o app
      theme: ThemeData(
        // Esquema de cores principal
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          primary: primaryColor,
          secondary: accentColor,
          surface: cardColor,
        ),
        scaffoldBackgroundColor: backgroundColor,

        // Tema para a AppBar
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white, // Cor do título e ícones
          elevation: 2,
        ),

        // Tema para os campos de texto
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          floatingLabelStyle: const TextStyle(color: primaryColor),
        ),
        
        // Tema para o Floating Action Button (botão de adicionar)
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: accentColor,
          foregroundColor: Colors.white,
        ),

        // Tema para os botões elevados
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: accentColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        // Usando a fonte Poppins do Google Fonts para a tipografia
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const TodoMenuPage(),
    );
  }
}