import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

enum MenuOptions { deleteOnComplete }

class Menu extends StatelessWidget {
  const Menu({Key key}) : super(key: key);

  // Future<void> onSelected(BuildContext context, MenuOptions result) async {
  //   if (result == MenuOptions.deleteOnComplete) {
  //     final currentSetting =
  //         context.read(settingsProvider).state.deleteOnComplete;
  //     context.read(settingsProvider).state =
  //         Settings(deleteOnComplete: !currentSetting);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // final isChecked = watch(settingsProvider).state.deleteOnComplete;
    return PopupMenuButton<MenuOptions>(
      onSelected: (result) {
        // onSelected(context, result);
      },
      icon: const Icon(
        Icons.menu,
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuOptions>>[
        PopupMenuItem<MenuOptions>(
          value: MenuOptions.deleteOnComplete,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Delete on complete'),
              Checkbox(
                value: false,
                onChanged: null,
              )
            ],
          ),
        ),
      ],
    );
  }
}
