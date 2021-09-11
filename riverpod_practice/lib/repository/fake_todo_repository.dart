import 'dart:convert';
import 'dart:math';

import 'package:riverpod_practice/models/todo.dart';
import 'package:riverpod_practice/repository/todo_repository.dart';

final _sampleJsonTodos = [
  '''{"description": "Buy cat food", "id": "ef902705-b65e-49bf-b723-cdcb4bfa7327", "completed": false}''',
  '''{"description": "Learn Riverpod", "id": "ef902705-b65e-49bf-b723-cdcb4bfa7329", "completed": true}''',
  '''{"description": "Play games", "id": "0704c57a-6901-40db-88dc-b22269af658b", "completed": false}''',
];

class TodoException implements Exception {
  final String error;

  const TodoException(this.error);

  @override
  String toString() {
    return """
    Todo Error: $error
    """;
  }
}

const double errorLikelihood = 0.1;

class FakeTodoRepository implements TodoRepository {
  FakeTodoRepository() : random = Random() {
    mockTodoStorage = [
      ..._sampleJsonTodos.map((todoJson) {
        return Todo.fromJson(json.decode(todoJson) as Map<String, dynamic>);
      })
    ];
  }

  final Random random;
  late List<Todo> mockTodoStorage;

  @override
  Future<void> addTodo(String description) async {
    await _waitRandomTime();
    if (random.nextDouble() < errorLikelihood) {
      throw const TodoException("Todos could not be added");
    } else {
      mockTodoStorage = [...mockTodoStorage, Todo.create(description)];
    }
  }

  @override
  Future<void> edit({required String id, required String description}) async {
    await _waitRandomTime();
    if (random.nextDouble() < errorLikelihood) {
      throw const TodoException("Todos could not be added");
    } else {
      mockTodoStorage = [
        for (final todo in mockTodoStorage)
          if (todo.id == id)
            todo.copyWith(
              description: description,
            )
          else
            todo,
      ];
    }
  }

  @override
  Future<void> remove(String id) async {
    await _waitRandomTime();
    if (random.nextDouble() < errorLikelihood) {
      throw const TodoException("Todos could not be removed");
    } else {
      mockTodoStorage = mockTodoStorage.where((todo) => todo.id != id).toList();
    }
  }

  @override
  Future<List<Todo>> retrieveTodos() async {
    await _waitRandomTime();
    // retrieving mock storage
    if (random.nextDouble() < 0.3) {
      throw const TodoException('Todos could not be retrieved');
    } else {
      return mockTodoStorage;
    }
  }

  @override
  Future<void> toggle(String id) async {
    await _waitRandomTime();
    if (random.nextDouble() < errorLikelihood) {
      throw const TodoException("Todo could not be toggled");
    } else {
      mockTodoStorage = mockTodoStorage.map((todo) {
        if (todo.id == id) {
          return todo.copyWith(
            completed: todo.completed,
          );
        }
        return todo;
      }).toList();
    }
  }

  Future<void> _waitRandomTime() async {
    await Future<dynamic>.delayed(
      Duration(
        seconds: random.nextInt(3),
      ),
    );
  }
}
