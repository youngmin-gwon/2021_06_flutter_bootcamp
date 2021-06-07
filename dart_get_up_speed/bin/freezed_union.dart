// freezed union case
// - multiple classes가 그룹을 이루고 있는 것

import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezed_union.freezed.dart';

void unionTest() {
  // final myObject = SubClass2() as SuperClass;
  // // 만약 코드를 진행하다가 이 object가 어떤 object인지 궁금할 때
  // if (myObject is SubClass1) {
  // } else if (myObject is SubClass2) {}
  // 이런식으로 처리하다가 만약 subclass가 추가된 경우?
  // => 계속 추가되어야 함
  // => 프로그래머가 까먹지 않고 계속 추가해줘야함
  // => freezed union을 사용하는 이유

  const resultSuccess = const Result.success(100);
  // 왜 freezed 가 유용한가
  // => runtime error를 만들어서 모든 케이스를 확인할 수 있게 만들어줌
  // 1. when
  print(resultSuccess.when(
      success: (value) => "Yes! Data gotten successfully",
      failure: (value) => "Oh no, an error occurred: $value",
      //새로운 subclass를 추가 하지 않았을 때 추가하라고 알려줌
      loading: () => "Loading..."));

  // 2. maybeWhen
  // 특정 케이스만 확인하고 싶을 때
  print(resultSuccess.maybeWhen(
      failure: (errorMessage) => "Oh, error occurred", orElse: () => ""));

  // 3. map
  // when은 subclass들이 받는 params를 넘기지만 map은 subclass 자체를 넘김
  print(resultSuccess.map(
      success: (successCase) =>
          "Yes! Data gotten successfully ${successCase.value}",
      failure: (failureCase) =>
          "Oh no, an error occurred: ${failureCase.errorMessage}",
      loading: (loadingCase) => "Loading..."));

// 4. maybeMap
  print(resultSuccess.maybeMap(
    failure: (failureCase) =>
        "Oh no, an error occurred: ${failureCase.errorMessage}",
    orElse: () => "failed",
  ));
}

// class SuperClass {}

// class SubClass1 extends SuperClass {
//   final String y = "S";
// }

// class SubClass2 extends SuperClass {
//   final int x = 123;
// }

// // +
// class SubClass3 extends SuperClass {
//   final bool t = true;
// }

@freezed
class Result with _$Result {
  const Result._();
  // sub class는 factory로 정의됨
  // 하나만 있는 경우  data class, 여러개 있는 경우 union
  const factory Result.success(int value) =
      _Success; // redirect constructor이기 때문에 package private 으로 만듬
  const factory Result.failure(String errorMessage) =
      _Failure; //redirect constructor이기 때문에 package private 으로 만듬
  const factory Result.loading() = _Loading;
}
