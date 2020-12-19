import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:riverpor_syncValueChanges/repository/fake_todo_repository.dart';
import 'package:riverpor_syncValueChanges/todo_state.dart';

import 'todo_item.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer(builder: (context, watch, child) {
        final todo = watch(todosNotifierProvider.state);
        return RefreshIndicator(
            child: ListView(
              children: todo
                  .map((e) => ProviderScope(
                        overrides: [currentTodo.overrideWithValue(e)],
                        child: TodoItem(),
                      ))
                  .toList(),
            ),
            onRefresh: () {
              Future<void> rtn() {
                return Future.delayed(Duration(seconds: 5), () => print("aki"));
              }

              return rtn();
            });
      }),
    );
  }
}
