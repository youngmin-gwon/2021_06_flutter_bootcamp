void errorHandling() {
  try {
    final myInt = int.parse("sdfdsfdsf");
    // error 발생시킴
    // throw MyCustomException();
    throw "do not do this";
  } on FormatException {
    print("format exception");
  } finally {
    print("this always runs");
  }
}

// Exception : app 을 crash 하지는 않음
class MyCustomException implements Exception {}

// Error : App 을 crash 함
class MyCustomError extends Error {}
