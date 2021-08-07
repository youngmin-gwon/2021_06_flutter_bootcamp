import 'package:animation_course/0_widgets/widgets.dart';
import 'package:animation_course/4_staggered_animation/2_signin_animation/widgets/forms/call_to_action_text.dart';
import 'package:animation_course/4_staggered_animation/2_signin_animation/widgets/forms/text_input_box.dart';
import 'package:flutter/material.dart';

import '../determine_visibility.dart';
import 'call_to_action_button.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    Key? key,
    required this.onLoginPressed,
    required this.onSignupPressed,
    required this.safeArea,
  }) : super(key: key);

  final VoidCallback onLoginPressed;
  final VoidCallback onSignupPressed;
  final double safeArea;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: safeArea),
          child: Column(
            children: <Widget>[
              const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CallToActionText(text: "Create an account")),
              const TextInputBox(
                icon: Icons.portrait,
                hintText: 'Name',
              ),
              const TextInputBox(
                icon: Icons.email,
                hintText: 'Email',
              ),
              const TextInputBox(
                icon: Icons.lock_outline,
                hintText: 'Password',
                obscureText: true,
              ),
              CallToActionButton(
                  onPressed: onSignupPressed,
                  text: 'Sign Up',
                  color: headerSignUpColor),
              DetermineVisibility(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Expanded(
                      flex: 3,
                      child: Center(
                          child: CallToActionText(
                              text: 'Already have an account?')),
                    ),
                    Expanded(
                      child: CallToActionButton(
                        text: 'Sign in',
                        onPressed: onLoginPressed,
                        color: headerLoginColor,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
