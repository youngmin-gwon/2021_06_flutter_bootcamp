import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

var _uuid = const Uuid();

///
@freezed
class Todo with _$Todo {
  ///
  const factory Todo({
    ///
    required String id,

    ///
    required String description,

    ///
    @Default(false) bool completed,
  }) = _Todo;

  const Todo._();

  ///
  factory Todo.create(String description) =>
      Todo(id: _uuid.v4(), description: description);

  ///
  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}
