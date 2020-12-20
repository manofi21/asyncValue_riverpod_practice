import 'dart:math';

import 'package:riverpor_syncValueChanges/model/todo.dart';
import 'package:riverpor_syncValueChanges/repository/todo_repositories.dart';

final sampleTodos = [
  Todo('Buy cat food'),
  Todo('Learn Riverpod'),
];

class TodoException implements Exception {
  const TodoException(this.error);

  final String error;

  @override
  String toString() {
    return '''
Todo Error: $error
    ''';
  }
}

class FakeTodoRepository implements TodoRepository {
  FakeTodoRepository() : random = Random() {
    mockTodoStorage = [...sampleTodos];
  }

  List<Todo> mockTodoStorage;
  final Random random;

  @override
  Future<List<Todo>> retrieveTodos() async {
    await _waitRandomTime();
    // retrieving mock storage
    if (random.nextDouble() < 0.3) {
      throw const TodoException('Todos could not be retrieved');
    } else {
      return mockTodoStorage;
    }
  }

  Future<void> _waitRandomTime() async {
    await Future.delayed(
      Duration(seconds: random.nextInt(3)),
      () {},
    ); // simulate loading
  }

  @override
  Future<void> addTodo(String description) {
      throw UnimplementedError();
    }
  
    @override
    Future<void> edit({String id, String description}) {
      throw UnimplementedError();
    }
  
    @override
    Future<void> remove(String id) {
      throw UnimplementedError();
    }
  
    @override
    Future<void> toggle(String id) {
    throw UnimplementedError();
  }
}
