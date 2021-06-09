import 'package:flutter/material.dart';
import 'package:flutter_foundation/randomizer.dart';
import 'package:flutter_foundation/range_selector_form.dart';

// 만약 state를 뽑아내고 아예 상관 없는 widget tree로 뽑아내고 싶을 때? => mutable state management => ChangeNotifier
// mutable state management? (hooks는 kinda immutable state management)
// => setState
// 의미 : 해당 영역에서 field를 재할당한다
class RangeSelector extends StatelessWidget {
  RangeSelector({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // hooks 기능 : build 안에서만 가능
    // hooks 특이한점? => 순서를 타기 때문에 순서를 바꿔줬다면 hot restart 해주기
    // final min = useState<int>(0);
    // final max = useState<int>(0);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Range"),
      ),
      body: RangeSelectorForm(
        formKey: formKey,
        // minValueSetter: (value) => min.value = value,
        // maxValueSetter: (value) => max.value = value,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward),
        onPressed: () {
          if (formKey.currentState?.validate() == true) {
            formKey.currentState?.save();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RandomizerPage(
                    // min: min.value,
                    // max: max.value,
                    )));
          }
        },
      ),
    );
  }
}
