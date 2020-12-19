import 'package:flutter_riverpod/all.dart';
import 'package:riverpor_syncValueChanges/repository/fake_todo_repository.dart';

import 'model/todo.dart';

final currentTodo = ScopedProvider<Todo>(null);

final todosNotifierProvider = StateNotifierProvider<TodoNotifier>((ref) {
  return TodoNotifier(ref.read, sampleTodos);
});

final completedTodos = Provider<List<Todo>>((ref) {
  // Method 4
  final todos = ref.watch(todosNotifierProvider.state);
  return todos.where((todo) => todo.completed).toList();
});

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier(this.read, [List<Todo> state]) : super(state ?? <Todo>[]);
  final Reader read;

  void add(String description) {
    state = [...state]..add(Todo(description));
  }
}
