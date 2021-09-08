import 'dart:math';

import 'package:riverpod_practice/models/todo.dart';
import 'package:riverpod_practice/repository/todo_repository.dart';

final _sampleTodos = [
  Todo("Buy cat food"),
  Todo("Learn Riverpod"),
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
    mockTodoStorage = [..._sampleTodos];
  }

  final Random random;
  late List<Todo> mockTodoStorage;

  @override
  Future<void> addTodo(String description) async {
    await _waitRandomTime();
    if (random.nextDouble() < errorLikelihood) {
      throw const TodoException("Todos could not be added");
    } else {
      mockTodoStorage = [...mockTodoStorage, Todo(description)];
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
            Todo(
              description,
              id: todo.id,
              completed: todo.completed,
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
          return Todo(
            todo.description,
            id: todo.id,
            completed: !todo.completed,
          );
        }
        return todo;
      }).toList();
    }
  }

  Future<void> _waitRandomTime() async {
    await Future.delayed(
      Duration(
        seconds: random.nextInt(3),
      ),
    );
  }
}
