import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:riverpor_syncValueChanges/view/componen.dart/todo_item.dart';

import '../../todo_state.dart';

class CompletedTodos extends StatefulWidget {
  @override
  _CompletedTodosState createState() => _CompletedTodosState();
} //CompletedTodos

class _CompletedTodosState extends State<CompletedTodos> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final todosState = watch(completedTodos);
        return todosState.when(
          data: (todos) {
            return ListView(
              children: [
                ...todos
                    .map(
                      (todo) => ProviderScope(
                        overrides: [currentTodo.overrideWithValue(todo)],
                        child: TodoItem(),
                      ),
                    )
                    .toList()
              ],
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (e, st) => const Center(
            child: Text('Something went wrong'),
          ),
        );
      },
    );
  }
}
// Future<void> rtn() {
//   return Future.delayed(Duration(seconds: 5), () => print("aki"));
// }

// return rtn();
