import 'package:animation_course/0_widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: backgroundHomeDecoration(),
          width: double.infinity,
          height: double.infinity,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "Success!",
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: Colors.white,
                  ),
            ),
            Text(
              "This is the home page",
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ])),
    );
  }
}
