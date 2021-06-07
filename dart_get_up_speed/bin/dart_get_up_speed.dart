import 'package:meta/meta.dart';

import 'async_future.dart';
import 'error_handling.dart';
import 'freezed_union.dart';

// package connection
part 'package_test.dart';

void main(List<String> arguments) {
  // nonassignable인 경우?
  // -> final, const

  // Non-Nullability
  // - !를 쓰는것을 자제하고 ?을 쓰도록하자
  String? possible;
  print(possible?.length);

  // Operators
  // - truncate : ~/ => int로 정의했던것을 double로 만들지 않게 됨
  print(5 ~/ 3);

  // - Uni-operator
  int x = 5;
  print(x--);
  print(x++);
  print(x += 5);

  // Switch practice
  final myInteger = 5;
  switch (myInteger) {
    case 10:
      print('it is ten');
      break;
    case 9:
      print('it is nine');
      break;

    default:
      print('it is something else');
  }

  // for (just writing)
  for (var i = 0; i < 10; i++) {
    print(i);
  }

  do {
    print('Hello');
  } while (false);

  // Higher Order Function

  final twicePlusFive = twice((x) => x + 5);
  final result = twicePlusFive(3);

  print(result);

  // higher order practice
  final tripp = tripple((x) => x + 5);
  final results = tripp(3);
  print(results);

  // collection
  final List<int> myList = [1, 2, 3, 4];
  // - race 없음
  myList.length;
  final firstElement = myList[0];
  // - dart 에서 타입 안적어도 자체적으로 지원
  final myList2 = [1, 2, 3, 4, 'dynamic'];
  // - flutter에서 유용한 방법 : List Literal
  <int>[1, 2, 3, 4];

  // Map
  Map<String, dynamic> mapTest = {
    'name': 'John Doe',
    'age': 42,
    'registered': true
  };
  final name = mapTest['name'];

  // Set
  Set<int> mySet = {1, 2, 3, 2, 3, 4};
  print(mySet.length); // 중복되는 것은 제외하고 선택됨

  // collection 이 제공해야하는 것들
  final names = ['John', 'Jane', 'Matthew'];

  // map : 안에 anonymous function 넣음
  // - 모든 요소에 접근하여 적용
  final nameLengthIter = names.map((name) => name.length);
  // - List가 아니라 Iterable로 변환되는 것 주의
  // - 이런식으로 접근 안됨 nameLength[0];
  final nameLengthList = names.map((name) => name.length).toList();
  print(nameLengthList[0]);
  // where : map 처럼 돌면서 filter의 기능을함
  final namefilterList = names.where((name) => name.length == 4).toList();
  print(namefilterList);
  // 각각 뽑아보기
  for (var i = 0; i < namefilterList.length; i++) {
    print(namefilterList[i]);
  }
  // for in 사용해서 뽑아보기
  for (var name in namefilterList) {
    print(name);
  }
  // foreach 사용해보기
  namefilterList.forEach((name) => print(name));
  namefilterList.forEach(print);

  // collection if, for, spread
  bool isSignedIn = true;
  <String>[
    'This is a fake content.',
    if (isSignedIn) 'Sign Out' else 'Sign In',
  ];
  // for in list
  final xyz = <String>[
    for (var i = 0; i < 5; i++) i.toString(),
    for (var number in [1, 2, 3]) number.toString()
  ];
  print(xyz);
  // spread in list
  final list1 = ['hello', 'there'];
  final list2 = ['what', 'up'];
  final list3 = <String>[
    ...list1,
    ...list2,
  ];
  print(list3);

  // enum
  final userAccountType = AccountType.premium;
  print(userAccountType.index);
  print(AccountType.values[userAccountType.index]);
  // enum이 유용한 경우 : switch => 나중되면 안쓰게 될 것임. freezed
  switch (userAccountType) {
    case AccountType.free:
      print('0 USD');
      break;
    case AccountType.premium:
      print('2 USD');
      break;
    default:
      break;
  }

  // class
  // final myUser = const User(name: 'John Doe', photoUrl: 'test.com');
  User myUser2 = const User(name: 'Jane Doe', photoUrl: 'test2.com');
  // const 로 정의하면서 identical 한 object는 instantiate 됨 => performance를 올리는 역할
  User myUser3 = const User(name: 'Jane Doe', photoUrl: 'test2.com');
  User myUser4 = User(name: 'Jane Doe', photoUrl: 'test2.com');
  // const 이기 때문에 같음
  print(myUser2 == myUser3);
  // const 가 아니기 때문에 다름
  print(myUser2 == myUser4);
  // 왜 다르다고 하는가? => referential equality 때문
  print(myUser2.hashCode);
  print(myUser3.hashCode); // 위의 두 개는 메모리 위치가 같음
  print(myUser4.hashCode); // const 가 아니기 때문에 메모리 위치가 다름

  // class - static
  print(User.minNameLength);

  final x1 = Example(1, 2);
  x1._private; // private 접근이 가능하다?
  // dart는 package private field 를 지원하기 때문에 => 같은 파일안에 있으면 접근 가능
  NonInstantiable._(); // 이런식으로 접근 가능

  // class에서 referential equality 가 아니라 value equality를 비교하는 방법 => class에 equality를 상속받으면 됨
  final equlUser1 = EqualityUser(firstName: 'John', lastName: 'Doe');
  EqualityUser equlUser2 = EqualityUser(firstName: 'John', lastName: 'Doe');
  print(equlUser1 == equlUser2);

  // extends
  final extendedCls =
      ExtendedClass(specialAdminField: 2.3, firstName: 'John', lastName: 'Doe');
  print(extendedCls.fullName);
  extendedCls.signOut();

  final convertedToExtending = extendedCls as ExtendingClass;
  // convertedToExtending.specialAdminField; // cookie cutter로 일부분을 잘라내니 잘라낸 부분에 있던 것을 사용할 수 없게 됨
  print(convertedToExtending.fullName); // Extended John Doe
  // => John Doe 가 나와야하는데 상속받은 내용이 나옴
  print(convertedToExtending is! ExtendedClass); // false

  // 이렇게 정의하면 extended class의 field 접근 가능하게 됨
  if (convertedToExtending is ExtendedClass) {
    print(convertedToExtending.specialAdminField);
  }

  // factory class
  final metaCls = MetaClass.extended(true);
  print(metaCls);

  // abstract class
  // - instantiation 불가능
  // AbstractClass('test','test');

  // interface
  OtherClass() as RegularClass; // abstract class 이지만 가능

  // mixin
  final bot = ChatbotChannel('123');
  bot.sendElevatedMessage('hello');

  final admin =
      AdminChannel(specialAdminField: 1, firstName: 'test', lastName: 'test');
  admin.sendElevatedMessage('admin');

  // extension
  final dup = 'hello'.duplicate();
  print(dup);
  final dup2 = 'hello'.duplicated;
  print(dup2);

  // package connection
  // - part, part of로 연결하여 private class 사용할 수 있게 됨!
  _PackagePrivateClass._('_privateField');

  // freezed union
  unionTest();

  // error handling
  errorHandling();

  // async
  // asyncTest();
  // async2Test();

  // steam
  // stream1Test();
  streamGeneratorTest();
}

// function parameter
void optionalPositionalParams(int x, int y, [String greeting = 'Hi']) {
  optionalPositionalParams(32, 25);
  optionalPositionalParams(32, 25, 'test');
}

void namedOptionalParams({
  int? x,
  double? y,
  String? greeting,
}) {
  namedOptionalParams(x: 23, y: 3.4, greeting: 'test');
  namedOptionalParams(x: 23, greeting: 'test');
}

// Higher Order
// - Function을 다른 Function에서 받는, 혹은 내보내는 메소드
// - dart에서 functional programming을 구현할 수 있게 해주는 요소
// - decode하기 어렵다는 단점도 있음

// 가독성을 높이기 위해 바꿔주는 작업
typedef IntTransFormer = int Function(int);

IntTransFormer // 리턴하는 Function type과 params
    twice(IntTransFormer f) // parameter에 주입하는 Function type과 params
// int Function(int) // 리턴하는 Function type과 params
//     twice(int Function(int) f) // parameter에 주입하는 Function type과 params
{
  // anonymous function : 굳이 정의하지 않고 바로 만들어서 넘겨버림
  return (int x) {
    return f(f(x));
  };
}

IntTransFormer tripple(IntTransFormer f) {
  return (x) => f(f(f(x)));
}

// enum
enum AccountType { free, premium, vip }

// class
class User {
  // String name;
  // String photoUrl;
  // 이름을 바꾸지 못하게 하고 싶을때 final
  final String name;
  final String photoUrl;

  // User({
  // final 인자만 받을 때는 const로 memory optimization 하기
  const User({
    // first name, last name으로 받고 싶을 때?
    // required String firstName,
    // required String lastName,
    required this.name,
    required this.photoUrl,
  })
  // constructor도 함수다 => constructor body({...})을 가질 수 있음 => 쓸일 많이 없음
  // {name = '$firstName $lastName';}
  // late 로 처리해줘야하니 다음 방법으로
  // :name = '$firstName $lastName';
  ;

  bool hasLongName() {
    return name.length > 10;
  }

  // 여태까지 instance member 만 사용함
  // - instance member: object에 포함된 field, method

  // 만약 instance를 안타고 사용하고 싶다? => static
  static void myMethod() {}

  static const minNameLength = 3;
}

// class private members
class Example {
  int public;
  int _private;

  // constructor 는 여러개 만들 수 있음
  // - 1. unnamed constructor
  Example(this.public, this._private);
  // - 2. named constructor => private field 정의시 문제가 생김 => 이전에 사용했던 방법으로 : 이후에 정의
  Example.namedConstructor({
    required this.public,
    required int privateParameter,
  }) : _private = privateParameter;

  // private field가 외부에서 접근이 가능하다?
  // - dart에는 class private field 가 없음
  // - dart에는 *package private field* 가 있음
}

// private class
class NonInstantiable {
  NonInstantiable._();
}

// class properties
class PropertyUser {
  final String firstName;
  final String lastName;
  // email 을 받음
  String? _email;
  // 어떻게 validate 하는가

  PropertyUser(
      {required this.firstName,
      required this.lastName,
      required String email}) {
    this.email = email;
    // this.email : setter
  }

  // getter
  // String getFullName() => '$firstName $lastName';
  // - 이름이 적당하지 않음 => field, method  둘다 아니기 때문
  //   => property를 여기서 사용함
  String get fullName => '$firstName $lastName';

  // setter
  // void setEmail(String value) {
  //   if (value.contains('@')) {
  //     _email = value;
  //   } else {
  //     _email = null;
  //   }
  // }
  set email(String value) {
    if (value.contains('@')) {
      _email = value;
    } else {
      _email = null;
    }
  }

  String get emial => _email ?? 'Email not present';
}

// class Equality
class EqualityUser {
  final String firstName;
  final String lastName;
  const EqualityUser({
    required this.firstName,
    required this.lastName,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EqualityUser &&
        other.firstName == firstName &&
        other.lastName == lastName;
  }

  @override
  int get hashCode => firstName.hashCode ^ lastName.hashCode;
}

// extending class
//  - 모든 class는 Object로 부터 extends 되었음
//  - class User extends Object{...} 라는 의미
//  - super class = extended class
class ExtendingClass {
  final String _firstName;
  final String _lastName;

  ExtendingClass(this._firstName, this._lastName);

  String get fullName => '$_firstName $_lastName';

  @mustCallSuper
  void signOut() {
    print('Signing out.');
  }
}

class ExtendedClass extends ExtendingClass {
  // parameter 추가하는 것도 가능
  final double specialAdminField;

  // 상속하는 field들을 받아야함
  ExtendedClass({
    required this.specialAdminField,
    required String firstName,
    required String lastName,
  }) : super(firstName, lastName);
  // super : super constructor => super class에 각각 인자 전달한다는 의미
  // 부모 class 에서는 positional parameter 로 넘겼지만, 자식 class 에서는 named parameter로 받는것 가능
  //  => 인자만 잘 넘기면 됨

  // 상속 받는 것 가능 (redundant)
  @override
  String get fullName => 'Extended ${super.fullName}';

  @override
  void signOut() {
    print('Performing Extended-specific Sign-Out steps');
    // 문제 : 반드시 상속한 클래스의 해당 메소드를 수행해야하는데 지워버릴 수 있음
    // => meta package @mustCallSuper annotation 사용해야함 !
    super.signOut();
  }
}

// factory class
//  - 상속할 때 constructor을 사용하지 않고 class 를 instantiate 하는 방법
//  - class를 instantiate 하는 것 처럼 보이지만 subclass를 만드는 방법?
class MetaClass {
  final String _firstName;
  final String _lastName;

  MetaClass(this._firstName, this._lastName);

  // constructor가 nameless factory기 때문에 naming sub class를 만듬
  // 밖에서 보기에는 constructor 처럼 보임
  factory MetaClass.extended(bool admin) {
    if (admin) {
      return MetaExtendedClass(
          specialAdminField: 123, firstName: 'John', lastName: 'Doe');
    } else {
      return MetaClass('1', '2');
    }
  }

  String get fullName => '$_firstName $_lastName';

  @mustCallSuper
  void signOut() {
    print('Signing out.');
  }
}

class MetaExtendedClass extends MetaClass {
  final double specialAdminField;

  MetaExtendedClass({
    required String firstName,
    required String lastName,
    required this.specialAdminField,
  }) : super(firstName, lastName);

  @override
  String get fullName => '$_firstName $_lastName';

  @override
  void signOut() {
    print('Signing out.');
    super.signOut();
  }
}

// abstract class
//  - 여태까지 class는 모두 instantiate 했지만, abstract class는 안함
//  - extending 하기 위해 사용
//  - instantiate 할 수 없다는 것 잘 기억
//  - explicit type casting 불가능
//  - interface 역할
abstract class AbstractClass {
  final String _firstName;
  final String _lastName;

  AbstractClass(this._firstName, this._lastName);

  String get fullName => '$_firstName $_lastName';

  @mustCallSuper
  void signOut() {
    print('Signing out.');
  }

  // 상세 내용 정의해주지 않아도 됨 => 대신 상속 받는 클래스에서 무조건 정의해줘야 함
  void myMethod();
  int get myProperty;
  // 무조건 상속 받는 곳에서 정의해줘야 함!
}

// interface : dart에는 term이 없음 => 모든 class가 interface 역할을 할 수 있음
// - 일반적으로는 아무것도 구현되어 있지 않은 abstract class 를 사용
class RegularClass {
  final int myField;

  RegularClass(this.myField);

  int get publicProperty => 123;

  String getSomeString() => 'Hello';
}

class OtherClass implements RegularClass {
  // implements 하면 항상 상속 전의 class의 맴버들을 override 해줘야함
  @override
  String getSomeString() {
    // TODO: implement getSomeString
    throw UnimplementedError();
  }

  // field 도 상속 받아야함
  @override
  // TODO: implement myField
  int get myField => throw UnimplementedError();

  @override
  // TODO: implement publicProperty
  int get publicProperty => throw UnimplementedError();
}

// interface 예시 + Generic
abstract class DataReader<T> {
  T readData();
}

class IntegerDataReader implements DataReader<int> {
  @override
  int readData() {
    print('performing logic');
    return 1234;
  }
}

class StringDataReader implements DataReader<String> {
  @override
  String readData() {
    print('performing logic');
    return "1234";
  }
}

// method도 가능
void myMethod<T>(T arg) {}

// mixin
// - 같은 기능을 상속받지 않는 class에서 사용하고 싶을 때
class UserChannel {
  final String firstName;
  final String lastName;

  UserChannel(this.firstName, this.lastName);
}

// mixin!
// - instantiation 불가능
// - explicit type casting 불가능
// - with를 이용하여 사용
mixin ElevatedClient {
  void sendElevatedMessage(String text) {
    print('Sending a message with an elevated importance: $text');
  }
}

class AdminChannel extends UserChannel with ElevatedClient {
  final double specialAdminField;
  AdminChannel(
      {required this.specialAdminField,
      required String firstName,
      required String lastName})
      : super(firstName, lastName);
}

class ChatbotChannel with ElevatedClient {
  final String id;
  ChatbotChannel(this.id);
}

// extension
// - 직접 정의하지 않은 system class, library class에 API 추가하는 기능
extension StringDuplication on String {
  String duplicate() {
    return this + this;
  }

  // property도 가능
  String get duplicated => this + this;
}

// package field
void _oppositeWay() {}
