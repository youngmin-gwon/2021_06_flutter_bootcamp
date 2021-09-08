import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

var _uuid = const Uuid();

@immutable
class Todo {
  final String id;
  final String description;
  final bool completed;

  Todo(
    this.description, {
    String? id,
    this.completed = false,
  }) : id = id ?? _uuid.v4();
}
