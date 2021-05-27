import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezed_class.freezed.dart';

@freezed
class Person with _$Person {
  const Person._();
  const factory Person({
    required String name,
    required int age,
  }) = _Person;
}
