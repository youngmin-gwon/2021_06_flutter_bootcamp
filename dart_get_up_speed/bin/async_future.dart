import 'package:http/http.dart';

// future : 한번 비동기 수행시
// stream : 지속적인 비동기 수행시

// future
Future<void> asyncTest() async {
  try {
    // http package
    final result = await Client()
        .get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    // Future class : async를 가능하게 해주는 wrapper class
    print(result.body);
  } catch (e) {
    print("error!");
  }
}

// 다음과 같이 수정 가능
void async2Test() {
  // low level way
  final result = Client()
      .get(Uri.parse("https://jsonplaceholder.typicode.com/posts"))
      .then((response) => print(response.body))
      // try catch
      .catchError((e) => print("error! $e"));
  // call back hell 이기 때문에 async로 나눠도 해서 상관 없음
}

// stream
Future<void> stream1Test() async {
  final myPeriodicStream = Stream.periodic(const Duration(seconds: 1));
  // 이 상태에서는 stream이 멈추지 않고 계속 진행됨
  // myPeriodicStream.listen((event) {
  //   print("A second has passed");
  // });
  final subscription = myPeriodicStream.listen((event) {
    print("A second has passed");
  });

  await Future.delayed(const Duration(seconds: 3));

  subscription.cancel();
}

// multiple api endpoint를 만들기 위해서 async generator을 만드는 방법
Future<void> streamGeneratorTest() async {
  createMessageStream().listen((event) {
    print(event);
  });
  // 이 경우는 infinite 한 stream이 아니기 때문에 cancel에 신경쓰지 않아도 됨

  // stream은 async collection으로 작동함
  //  => 시간에 따라 값을 받기 때문에 하나의 collection 처럼 적용할 수 있다고 보면 될듯
  //  => 어려운 말이지만 이 말을 하는 이유 => collection처럼 map, where 적용이 가능함
  createMessageStream()
      .map((message) => message.toUpperCase())
      .where((message) => message.length > 7)
      .listen((event) {
    print(event);
  });
}

// async* => returns Stream
Stream<String> createMessageStream() async* {
  // return 은 한번만 처리하고 내보내기 때문에 stream과는 어울리지 않음
  // return "Function";
  // yield : stream이 계속 subscription을 유지하면서 받은 결과를 내보내는 방법
  yield "Hello";
  await Future.delayed(const Duration(seconds: 1));
  yield "Have you heared of...";
  await Future.delayed(const Duration(seconds: 1));
  yield "Flutter!";
}
