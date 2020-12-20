import 'package:flutter_riverpod/all.dart';
import 'package:riverpor_syncValueChanges/repository/fake_todo_repository.dart';
import 'package:riverpor_syncValueChanges/repository/todo_repositories.dart';

import 'model/todo.dart';

final currentTodo = ScopedProvider<Todo>(null);

final todoRepositoryProvider = Provider<TodoRepository>((ref) {
  throw UnimplementedError();
});

final todosNotifierProvider = StateNotifierProvider<TodoNotifier>((ref) {
  return TodoNotifier(ref.read);
});

final completedTodos = Provider<AsyncValue<List<Todo>>>((ref) {
  // Method 4
  final todos = ref.watch(todosNotifierProvider.state);
  return todos
      .whenData((todos) => todos.where((todo) => todo.completed).toList());
});

class TodoNotifier extends StateNotifier<AsyncValue<List<Todo>>> {
  TodoNotifier(
    this.read, [
    AsyncValue<List<Todo>> todos,
  ]) : super(todos ?? const AsyncValue.loading()) {
    _retrieveTodos();
  }

  final Reader read;

  Future<void> _retrieveTodos() async {
    try {
      final todos = await read(todoRepositoryProvider).retrieveTodos();
      state = AsyncValue.data(todos);
    } on TodoException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> retryLoadingTodo() async {
    state = const AsyncValue.loading();
    try {
      final todos = await read(todoRepositoryProvider).retrieveTodos();
      state = AsyncValue.data(todos);
    } on TodoException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() => _retrieveTodos();
}
