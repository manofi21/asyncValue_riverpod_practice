import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:riverpor_syncValueChanges/model/settings.dart';
import 'package:riverpor_syncValueChanges/todo_state.dart';

enum _MenuOptions { deleteOnComplete }

class Menu extends ConsumerWidget {
  const Menu({Key key}) : super(key: key);

  Future<void> onSelected(BuildContext context, _MenuOptions result) async {
    if (result == _MenuOptions.deleteOnComplete) {
      final currentSetting =
          context.read(settingsProvider).state.deleteOnComplete;
      context.read(settingsProvider).state =
          Settings(deleteOnComplete: !currentSetting);
    }
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final isChecked = watch(settingsProvider).state.deleteOnComplete;
    return PopupMenuButton<_MenuOptions>(
      onSelected: (result) {
        print(result);
        onSelected(context, result);
      },
      icon: const Icon(
        Icons.menu,
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<_MenuOptions>>[
        PopupMenuItem<_MenuOptions>(
          value: _MenuOptions.deleteOnComplete,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Delete on complete'),
              Checkbox(
                value: isChecked,
                onChanged: null,
              )
            ],
          ),
        ),
      ],
    );
  }
}
