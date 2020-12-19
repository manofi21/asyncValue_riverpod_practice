import 'package:flutter/material.dart';
import 'package:riverpor_syncValueChanges/view/componen.dart/todo_item.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
          child: ListView(
            children: [TodoItem(), TodoItem()],
          ),
          onRefresh: () {
            Future<void> rtn() {
              return Future.delayed(Duration(seconds: 5), () => print("aki"));
            }

            return rtn();
          }),
    );
  }
}
