import 'package:flutter/material.dart';
import 'package:flutter_foundation/randomizer_change_notifier.dart';
import 'package:flutter_foundation/range_selector_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(AppWidget());
}

// 이렇게 정의함으로서 어느 곳이나 들어갈 수 있게 됨
// global variable 처럼 보이나 클래스와 같은 레벨에 있기 때문에 global variable 이 아님 => mutable 하지 않고 immutable 하다는 의미
// 한번 instantiated 되면 앱이 꺼질 때, 혹은 widget dispose 전까지 남아있음
final randomizerProvider =
    ChangeNotifierProvider((ref) => RandomizerChangeNotifier());

class AppWidget extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // provider 를 사용하면서 생기는 문제 : provider widget을 여러개 제공하고 싶을 때 코드가 복잡해보이기 쉬움
    // 정의된 type 에만 기대고 있는데 만약 2개의 같은 type의 changenotifier를 사용할 때 가장 가까운 것을 참고해서 문제가 생김
    return ProviderScope(
      // riverpod의 provider는 내부에 정의되어 있지 않다. 그럼 어디에 정의되어있는가? => anywhere!
      // return ChangeNotifierProvider(
      // create: (context) => RandomizerChangeNotifier(),
      // 이렇게 정의함으로서 RandomizerChangeNotifier을 앱 모든 곳에서 접근할 수 있게 됨
      child: MaterialApp(
        title: 'Randomizer',
        home: RangeSelector(),
      ),
    );
  }
}
