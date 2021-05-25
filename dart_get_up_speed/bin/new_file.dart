import 'dart_get_up_speed.dart';

void exampleMethod() {
  final x = Example(1, 2);
  // x._private; << 불가능
  //  - separate package 이기 때문!

  // NonInstantiable._();
  // - private constructor을 사용하여 정의할 수 없게 됨
}
