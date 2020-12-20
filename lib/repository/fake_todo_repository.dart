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
