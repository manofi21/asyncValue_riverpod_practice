import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

import 'package:riverpor_syncValueChanges/todo_state.dart';

class AddTodoPanel extends StatefulWidget {
  @override
  _AddTodoPanelState createState() => _AddTodoPanelState();
}

class _AddTodoPanelState extends State<AddTodoPanel> {
  final _textEditingController = TextEditingController();

  void _submit([String value]) {
    context.read(todosNotifierProvider).add(_textEditingController.value.text);
    _textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            child: TextField(
          controller: _textEditingController,
          decoration: InputDecoration(hintText: 'New todo'),
          onSubmitted: _submit,
        )),
        IconButton(icon: Icon(Icons.check), onPressed: _submit)
      ],
    );
  }
}
