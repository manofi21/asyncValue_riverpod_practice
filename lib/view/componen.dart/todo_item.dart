import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

bool hasFocus = false;

class TodoItem extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _textEditingController = useTextEditingController();
    final _textFocusNode = useFocusNode();

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Dismissible(
        key: UniqueKey(),
        background: Container(color: Colors.red),
        onDismissed: null,
        child: FocusScope(
          child: Focus(
              child: ListTile(
                  onTap: null,
                  title: TextField(
                      focusNode: _textFocusNode,
                      controller: _textEditingController),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(value: false, onChanged: null),
                      IconButton(icon: Icon(Icons.delete), onPressed: null)
                    ],
                  ))),
        ),
      ),
    );
  }
}
