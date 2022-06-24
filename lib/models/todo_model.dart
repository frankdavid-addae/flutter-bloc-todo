import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Todo extends Equatable {
  final String id;
  final String task;
  final String description;
  bool? isCompleted;
  bool? isCancelled;

  Todo({
    required this.id,
    required this.task,
    required this.description,
    this.isCompleted,
    this.isCancelled,
  }) {
    isCompleted ??= false;
    isCancelled ??= false;
  }

  Todo copyWith({
    String? id,
    String? task,
    String? description,
    bool? isCompleted,
    bool? isCancelled,
  }) {
    return Todo(
      id: id ?? this.id,
      task: task ?? this.task,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      isCancelled: isCancelled ?? this.isCancelled,
    );
  }

  @override
  List<Object?> get props => [id, task, description, isCompleted, isCancelled];

  static List<Todo> todos = [
    Todo(id: '1', task: 'Sample todo 1', description: 'This is a test todo 1'),
    Todo(id: '2', task: 'Sample todo 2', description: 'This is a test todo 2'),
  ];
}
