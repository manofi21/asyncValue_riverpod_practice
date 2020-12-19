import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:riverpor_syncValueChanges/todo_state.dart';

bool hasFocus = false;

class TodoItem extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _textEditingController = useTextEditingController();
    final _textFocusNode = useFocusNode();

    return Consumer(builder: (context, watch, select) {
      final todo = watch(currentTodo);
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
                    title: hasFocus
                        ? TextField(
                            focusNode: _textFocusNode,
                            controller: _textEditingController,
                          )
                        : Text(todo.description),
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
    });
  }
}
