import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_todo/blocs/todos/todo_bloc.dart';
import 'package:flutter_bloc_todo/blocs/todos_filter/todos_filter_bloc.dart';
import 'package:flutter_bloc_todo/models/todo_model.dart';
import 'package:flutter_bloc_todo/models/todos_filter_model.dart';
import 'package:flutter_bloc_todo/screens/add_todo_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('BloC Pattern - Todos'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddTodoScreen(),
                  ),
                );
              },
            ),
          ],
          bottom: TabBar(
            onTap: (tabIndex) {
              switch (tabIndex) {
                case 0:
                  BlocProvider.of<TodosFilterBloc>(context).add(
                    const UpdateTodos(todosFilter: TodosFilter.pending),
                  );
                  break;
                case 1:
                  BlocProvider.of<TodosFilterBloc>(context).add(
                    const UpdateTodos(todosFilter: TodosFilter.completed),
                  );
                  break;
              }
            },
            tabs: const [
              Tab(
                icon: Icon(Icons.pending),
              ),
              Tab(
                icon: Icon(Icons.add_task),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _toods('Pending Todos'),
            _toods('Completed Todos'),
          ],
        ),
      ),
    );
  }

  // BlocBuilder<TodosFilterBloc, TodosFilterState> _toods(String title) {
  //   return BlocBuilder<TodosFilterBloc, TodosFilterState>(
  //     builder: (context, state) {
  //       if (state is TodosFilterLoading) {
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //       if (state is TodosFilterLoaded) {
  //         return Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Container(
  //                 padding: const EdgeInsets.only(bottom: 8.0),
  //                 child: Text(
  //                   title,
  //                   style: const TextStyle(
  //                     fontSize: 18.0,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               ),
  //               ListView.builder(
  //                 shrinkWrap: true,
  //                 itemCount: state.filteredTodos.length,
  //                 itemBuilder: (context, index) {
  //                   return _todoCard(context, state.filteredTodos[index]);
  //                 },
  //               ),
  //             ],
  //           ),
  //         );
  //       } else {
  //         return const Center(
  //           child: Text('Something went wrong!'),
  //         );
  //       }
  //     },
  //   );
  // }

  BlocConsumer<TodosFilterBloc, TodosFilterState> _toods(String title) {
    return BlocConsumer<TodosFilterBloc, TodosFilterState>(
      listener: (context, state) {
        if (state is TodosFilterLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'There are ${state.filteredTodos.length} todos in your $title list.',
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is TodosFilterLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is TodosFilterLoaded) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.filteredTodos.length,
                  itemBuilder: (context, index) {
                    return _todoCard(context, state.filteredTodos[index]);
                  },
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text('Something went wrong!'),
          );
        }
      },
    );
  }

  Card _todoCard(BuildContext context, Todo todo) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${todo.id}: ${todo.task}',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_task),
              onPressed: () {
                context.read<TodosBloc>().add(
                      UpdateTodo(
                        todo: todo.copyWith(isCompleted: true),
                      ),
                    );
              },
            ),
            IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: () {
                context.read<TodosBloc>().add(DeleteTodo(todo: todo));
              },
            ),
          ],
        ),
      ),
    );
  }
}
