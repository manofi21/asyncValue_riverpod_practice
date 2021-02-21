import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:riverpor_syncValueChanges/todo_state.dart';

class TodoItem extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _textEditingController = useTextEditingController();
    final _textFocusNode = useFocusNode();
    final _hasFocus = useState(false);

    return Consumer(builder: (context, watch, select) {
      final todo = watch(currentTodo);
      return Padding(
        padding: EdgeInsets.all(8.0),
        child: Dismissible(
          key: UniqueKey(),
          background: Container(color: Colors.red),
          onDismissed: (_) {
            context.read(todosNotifierProvider("60094bc2f02c148cda9e2f70")).remove(todo.id);
          },
          child: FocusScope(
            child: Focus(
                onFocusChange: (isFocused) {
                  if (!isFocused) {
                    _hasFocus.value = false;
                    // context.read(todosNotifierProvider).edit(
                    //     id: todo.id, description: _textEditingController.text);
                  } else {
                    // _textEditingController
                    //   ..text = todo.description
                    //   ..selection = TextSelection.fromPosition(TextPosition(
                    //       offset: _textEditingController.text.length));
                  }
                },
                child: ListTile(
                    onTap: () {
                      _hasFocus.value = true;
                      _textFocusNode.requestFocus();
                    },
                    title: _hasFocus.value
                        ? TextField(
                            focusNode: _textFocusNode,
                            controller: _textEditingController,
                          )
                        : Text(todo.name),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Checkbox(
                        //   value: todo.completed,
                        //   onChanged: (_) {
                        //     context.read(todosNotifierProvider).toggle(todo.id);
                        //   },
                        // ),
                        // IconButton(
                        //     icon: Icon(Icons.delete),
                        //     onPressed: () {
                        //       context
                        //           .read(todosNotifierProvider)
                        //           .remove(todo.id);
                        //     })
                      ],
                    ))),
          ),
        ),
      );
    });
  }
}
