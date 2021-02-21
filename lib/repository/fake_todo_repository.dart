import 'dart:math';

import 'package:riverpor_syncValueChanges/model/Card.dart';
import 'package:riverpor_syncValueChanges/model/todo.dart';
import 'package:riverpor_syncValueChanges/repository/todo_repositories.dart';
import 'package:http/http.dart' as http;
import '../trello_key.dart';

final sampleTodos = [
  Todo('Buy cat food'),
  Todo('Learn Riverpod'),
];

class TodoException implements Exception {
  const TodoException(this.error);

  final String error;

  @override
  String toString() {
    return '''
Todo Error: $error
    ''';
  }
}

const double errorLikelihood = 0.4;

class FakeTodoRepository implements TodoRepository {
  FakeTodoRepository() : mockTodoStorage = [];
  // random = Random() {

  // }

  List<TrelloCard> mockTodoStorage;
  final Random random = Random();

  @override
  Future<List<TrelloCard>> retrieveTodos(String id) async {
    try {
      final getRepos = await http
          .get(trelloApiCard(id))
          .then((value) => trelloCardFromJson(value.body));
      mockTodoStorage = [...getRepos];
      return mockTodoStorage;
    } catch (e) {
      throw TodoException(e.toString());
    }
  }

  // Future<void> _waitRandomTime() async {
  //   await Future.delayed(
  //     Duration(seconds: random.nextInt(3)),
  //     () {},
  //   ); // simulate loading
  // }

  @override
  Future<void> addTodo(String idList, String name, String description) async {
    try {
      final postCard = trelloPostCard();
      final getRepos = await http
          .post(postCard + "&idList=$idList&desc=$description&name=$name");
      print(getRepos.statusCode);
    } catch (e) {
      throw TodoException(e.toString());
    }
  }

  @override
  Future<void> edit({String id, String name, String description}) async {
    await Future.delayed(Duration(seconds: random.nextInt(3)));
    // updating mock storage
    if (random.nextDouble() < errorLikelihood) {
      throw const TodoException('Could not update todo');
    } else {
      mockTodoStorage = [
        for (final todo in mockTodoStorage)
          if (todo.id == id)
            TrelloCard(name: name, id: todo.id, desc: description)
          else
            todo,
      ];
    }
  }

  @override
  Future<void> remove(String id) async {
    await Future.delayed(Duration(seconds: random.nextInt(3)));

    // updating mock storage
    if (random.nextDouble() < errorLikelihood) {
      throw const TodoException('Todo could not be removed');
    } else {
      mockTodoStorage =
          mockTodoStorage.where((element) => element.id != id).toList();
    }
  }

  @override
  Future<void> toggle(String id) async {
    // await _waitRandomTime();
    // // updating mock storage
    // if (random.nextDouble() < errorLikelihood) {
    //   throw const TodoException('Todo could not be toggled');
    // } else {
    //   mockTodoStorage = mockTodoStorage.map((todo) {
    //     if (todo.id == id) {
    //       return Todo(
    //         todo.description,
    //         id: todo.id,
    //         completed: !todo.completed,
    //       );
    //     }
    //     return todo;
    //   }).toList();
    // }
  }
}
