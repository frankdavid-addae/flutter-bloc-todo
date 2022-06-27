import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_todo/blocs/todos/todo_bloc.dart';
import 'package:flutter_bloc_todo/blocs/todos_filter/todos_filter_bloc.dart';
import 'package:flutter_bloc_todo/models/todo_model.dart';
import 'package:flutter_bloc_todo/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodosBloc>(
          create: (context) => TodosBloc()
            ..add(LoadTodos(todos: [
              Todo(
                id: '1',
                task: 'Sample todo 1',
                description: 'This is a test todo 1',
              ),
              Todo(
                id: '2',
                task: 'Sample todo 2',
                description: 'This is a test todo 2',
              ),
            ])),
        ),
        BlocProvider(
          create: (context) => TodosFilterBloc(
            todosBloc: BlocProvider.of<TodosBloc>(context),
          ),
        )
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
