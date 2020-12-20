import 'package:flutter/material.dart';
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

final todoExceptionProvider = StateProvider<TodoException>((ref) {
  return null;
});

class TodoNotifier extends StateNotifier<AsyncValue<List<Todo>>> {
  TodoNotifier(
    this.read, [
    AsyncValue<List<Todo>> todos,
  ]) : super(todos ?? const AsyncValue.loading()) {
    _retrieveTodos();
  }

  final Reader read;
  AsyncValue<List<Todo>> previousState;
//////Default Method//////////////////////////////
  void _resetState() {
    if (previousState != null) {
      state = previousState;
      previousState = null;
    }
  }

  void _handleException(TodoException e) {
    _resetState();
    read(todoExceptionProvider).state = e;
  }

  void _cacheState() {
    previousState = state;
  }
////////////////////////////////////////////////////

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

  Future<void> refresh() async {
    try {
      final todos = await read(todoRepositoryProvider).retrieveTodos();
      state = AsyncValue.data(todos);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> add(String description) async {
    _cacheState();
    state = state.whenData((todos) => [...todos]..add(Todo(description)));

    try {
      await read(todoRepositoryProvider).addTodo(description);
    } on TodoException catch (e) {
      _handleException(e);
    }
  }

  Future<void> edit({@required String id, @required String description}) async {
    _cacheState();
    state = state.whenData((todos) {
      return [
        for (final todo in todos)
          if (todo.id == id)
            Todo(
              description,
              id: todo.id,
              completed: todo.completed,
            )
          else
            todo
      ];
    });

    try {
      await read(todoRepositoryProvider).edit(id: id, description: description);
    } on TodoException catch (e) {
      _handleException(e);
    }
  }

  Future<void> remove(String id) async {
    _cacheState();
    state = state.whenData(
      (value) => value.where((element) => element.id != id).toList(),
    );
    try {
      await read(todoRepositoryProvider).remove(id);
    } on TodoException catch (e) {
      _handleException(e);
    }
  }
}
