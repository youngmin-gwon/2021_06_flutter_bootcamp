import 'package:animation_course/4_staggered_animation/2_signin_animation/page/auth_page.dart';
import 'package:flutter/material.dart';

class NavigateToSigninPage extends StatelessWidget {
  const NavigateToSigninPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AuthPage(),
              ));
            },
            child: const Text("4. Staggered Animation")),
      ),
    );
  }
}
