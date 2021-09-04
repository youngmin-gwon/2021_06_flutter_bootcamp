import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final uuidProvider = Provider<Uuid>(
  (ref) => const Uuid(),
);

final todosProvider = StateNotifierProvider<TodoNotifier, List<Todo>>(
  (ref) => TodoNotifier(ref.watch(uuidProvider), ref.read),
);

final completeTodos = Provider<List<Todo>>((ref) {
  final todos = ref.watch(todosProvider);
  return todos.where((todo) => todo.completed).toList();
});

class TodoNotifier extends StateNotifier<List<Todo>> {
  final Uuid _uuid;
  final Reader read;

  TodoNotifier(this._uuid, this.read, [List<Todo>? state])
      : super(state ?? <Todo>[]);

  void add(String description) {
    state = [
      ...state,
      Todo(
        id: _uuid.v4(),
        description: description,
      ),
    ];
  }

  void toggle(String id) {
    if (read(settingsProvider).state.deleteOnComplete) {
      remove(id);
      return;
    }

    state = state.map((todo) {
      if (todo.id == id) {
        return Todo(
          id: id,
          description: todo.description,
          completed: !todo.completed,
        );
      } else {
        return todo;
      }
    }).toList();
  }

  void edit(String id, String description) {
    state = state.map((todo) {
      if (todo.id == id) {
        return Todo(
          id: todo.id,
          description: description,
          completed: todo.completed,
        );
      } else {
        return todo;
      }
    }).toList();
  }

  void remove(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }
}

class Todo {
  final String id;
  final String description;
  final bool completed;

  const Todo({
    required this.id,
    required this.description,
    this.completed = false,
  });
}

final settingsProvider = StateProvider<Settings>(
  (ref) => const Settings(),
);

class Settings {
  final bool deleteOnComplete;
  const Settings({
    this.deleteOnComplete = false,
  });
}
