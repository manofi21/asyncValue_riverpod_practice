import 'package:flutter/material.dart';

import 'componen/addTodoPanel.dart';
import 'componen/menu.dart';
import 'componen/todo_list.dart';
import 'componen/complete_page.dart';

class TodoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'TODOS',
            style: Theme.of(context)
                .textTheme
                .headline3
                .copyWith(color: Colors.white),
          ),
          actions: [Menu()],
          bottom: const TabBar(
            tabs: [
              Text(
                'All',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Completed',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
            child: TabBarView(children: [
          Column(
            children: [
              AddTodoPanel(),
              SizedBox(
                height: 20,
              ),
              TodoList()
            ],
          ),
          CompletedTodos()
        ])),
      ),
    );
  }
}
