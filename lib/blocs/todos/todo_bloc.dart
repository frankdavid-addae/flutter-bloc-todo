import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_todo/models/todo_model.dart';
import 'package:meta/meta.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodosBloc extends Bloc<TodoEvent, TodosState> {
  TodosBloc() : super(TodosLoading()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<UpdateTodo>(_onUpdateTodo);
    on<DeleteTodo>(_onDeleteTodo);
  }

  void _onLoadTodos(LoadTodos event, Emitter<TodosState> emit) {
    emit(TodosLoaded(todos: event.todos));
  }

  void _onAddTodo(AddTodo event, Emitter<TodosState> emit) {
    final state = this.state;
    if (state is TodosLoaded) {
      emit(
        TodosLoaded(
          todos: [...state.todos, event.todo],
          // todos: List.from(state.todos)..add(event.todo),
        ),
      );
    }
  }

  void _onUpdateTodo(UpdateTodo event, Emitter<TodosState> emit) {
    final state = this.state;
    if (state is TodosLoaded) {
      emit(
        TodosLoaded(
          todos: state.todos.map((todo) {
            if (todo.id == event.todo.id) {
              return event.todo;
            }
            return todo;
          }).toList(),
        ),
      );
    }
  }

  void _onDeleteTodo(DeleteTodo event, Emitter<TodosState> emit) {
    final state = this.state;
    if (state is TodosLoaded) {
      emit(
        TodosLoaded(
          todos: state.todos.where((todo) => todo.id != event.todo.id).toList(),
        ),
      );
    }
  }
}
