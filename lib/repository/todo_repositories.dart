import 'package:meta/meta.dart';
import 'package:riverpor_syncValueChanges/model/Card.dart';
import 'package:riverpor_syncValueChanges/model/todo.dart';

abstract class TodoRepository {
  Future<List<TrelloCard>> retrieveTodos(String id);
  Future<void> addTodo(String idList, String name, String description);
  Future<void> toggle(String id);
  Future<void> edit({
    @required String id,
    @required String name,
    @required String description,
  });
  Future<void> remove(String id);
}
