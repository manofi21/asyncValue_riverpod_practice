import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:riverpor_syncValueChanges/view/body.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch:  Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus.unfocus(),
              child: TodoScreen(),
            )));
  }
}
