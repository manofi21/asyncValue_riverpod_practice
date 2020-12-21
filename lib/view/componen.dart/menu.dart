import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:riverpor_syncValueChanges/model/settings.dart';
import 'package:riverpor_syncValueChanges/todo_state.dart';

// enum _MenuOptions { deleteOnComplete }

class Menu extends HookWidget {
  const Menu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final valueState = useState(false);
    return Consumer(builder: (context, watch, child) {
      final isChecked = watch(settingsProvider);
      return PopupMenuButton<bool>(
        onSelected: (result) {
          valueState.value = !result;
          isChecked.state = Settings(deleteOnComplete: valueState.value);
        },
        icon: const Icon(
          Icons.menu,
        ),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<bool>>[
          PopupMenuItem<bool>(
            value: valueState.value,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Delete on complete'),
                Checkbox(value: valueState.value, onChanged: null)
              ],
            ),
          ),
        ],
      );
    });
  }
}
