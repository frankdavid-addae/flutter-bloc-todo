import 'package:flutter/material.dart';
import 'package:flutter_bloc_todo/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BloC Pattern - Todo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0XFF000A1F),
        appBarTheme: const AppBarTheme(
          color: Color(0XFF000A1F),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
