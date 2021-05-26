// package private
//  - 다른 파일에 있는 private class 는 가져올 수 없음
//  - 만약 연결해주고 싶은 두 파일의 link는 어떻게 만드는가?
//  - 전달하는 쪽에서 part of, 전달 받는 쪽에서 part 사용하여 사용
//  - 여기선 main에 적용하기 위해서 반대로 적었는데도 적용이 되버림..
part of 'dart_get_up_speed.dart';

class _PackagePrivateClass {
  final String _privateField;

  _PackagePrivateClass._(this._privateField);

  void getOppositeWay() {
    // 반대방향으로도 불러오기 가능
    _oppositeWay();
  }
}
