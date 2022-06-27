import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_todo/blocs/todos/todo_bloc.dart';
import 'package:flutter_bloc_todo/models/todo_model.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  TextEditingController? _idController;
  TextEditingController? _taskController;
  TextEditingController? _descriptionController;

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController();
    _taskController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _idController?.dispose();
    _taskController?.dispose();
    _descriptionController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc Pattern - Add Todo'),
      ),
      body: BlocListener<TodosBloc, TodosState>(
        listener: (context, state) {
          if (state is TodosLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Todo added successfully!'),
              ),
            );
          }
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _inputField('ID', _idController!),
                _inputField('Task', _taskController!),
                _inputField('Description', _descriptionController!),
                ElevatedButton(
                  onPressed: () {
                    var todo = Todo(
                      id: _idController!.text,
                      task: _taskController!.text,
                      description: _descriptionController!.text,
                    );
                    context.read<TodosBloc>().add(AddTodo(todo: todo));
                    Navigator.of(context).pop();
                  },
                  child: const Text('Add Todo'),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _inputField(
    String field,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$field: ',
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: 50.0,
          margin: const EdgeInsets.only(bottom: 10.0),
          width: double.infinity,
          child: TextFormField(
            controller: controller,
          ),
        ),
      ],
    );
  }
}
