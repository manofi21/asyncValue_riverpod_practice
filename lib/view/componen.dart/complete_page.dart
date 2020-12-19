import 'package:flutter/material.dart';
import 'package:riverpor_syncValueChanges/view/componen.dart/todo_item.dart';

class CompletedTodos extends StatefulWidget {
  @override
  _CompletedTodosState createState() => _CompletedTodosState();
} //CompletedTodos

class _CompletedTodosState extends State<CompletedTodos> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: ListView(
          children: [TodoItem(), TodoItem()],
        ),
        onRefresh: () {
          Future<void> rtn() {
            return Future.delayed(Duration(seconds: 5), () => print("aki"));
          }

          return rtn();
        });
  }
}
