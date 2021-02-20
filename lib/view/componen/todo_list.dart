import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
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
      child: Consumer(
        builder: (context, watch, child) {
          final todosState = watch(todosNotifierProvider.state);
          return todosState.when(
            data: (todos) {
              return RefreshIndicator(
                onRefresh: () {
                  return context.read(todosNotifierProvider).refresh();
                },
                child: ListView(
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
                ),
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (e, st) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Todos could not be loaded'),
                  RaisedButton(
                    onPressed: () {
                      context.read(todosNotifierProvider).retryLoadingTodo();
                    },
                    child: const Text('Retry'),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
