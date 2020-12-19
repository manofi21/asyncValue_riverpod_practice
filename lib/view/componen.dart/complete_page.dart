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
    return RefreshIndicator(child: Consumer(builder: (context, watch, child) {
      final todo = watch(completedTodos);
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
    }), onRefresh: () {
      Future<void> rtn() {
        return Future.delayed(Duration(seconds: 5), () => print("aki"));
      }

      return rtn();
    });
  }
}
