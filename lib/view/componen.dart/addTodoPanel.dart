import 'package:flutter/material.dart';

class AddTodoPanel extends StatefulWidget {
  @override
  _AddTodoPanelState createState() => _AddTodoPanelState();
}

class _AddTodoPanelState extends State<AddTodoPanel> {
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            child: TextField(
          controller: _textEditingController,
          decoration: InputDecoration(hintText: 'New todo'),
          onSubmitted: null,
        )),
        IconButton(icon: Icon(Icons.check), onPressed: null)
      ],
    );
  }
}
