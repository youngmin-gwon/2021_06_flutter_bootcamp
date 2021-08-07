import 'package:flutter/material.dart';

import 'package:animation_course/0_widgets/widgets.dart';
import 'package:animation_course/4_staggered_animation/2_signin_animation/widgets/determine_visibility.dart';
import 'package:animation_course/4_staggered_animation/2_signin_animation/widgets/forms/call_to_action_button.dart';
import 'package:animation_course/4_staggered_animation/2_signin_animation/widgets/forms/call_to_action_text.dart';
import 'package:animation_course/4_staggered_animation/2_signin_animation/widgets/forms/text_input_box.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
    required this.onSignupPressed,
    required this.onLoginPressed,
    required this.safeArea,
  }) : super(key: key);

  final VoidCallback onSignupPressed;
  final VoidCallback onLoginPressed;
  final double safeArea;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: safeArea),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  bottom: 16.0,
                ),
                child: CallToActionText(text: "Please sign in to continue"),
              ),
              const TextInputBox(
                icon: Icons.email,
                hintText: "Email",
              ),
              CallToActionButton(
                  onPressed: onLoginPressed,
                  text: "Login",
                  color: headerLoginColor),
              DetermineVisibility(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                    flex: 3,
                    child: Center(
                      child: CallToActionText(text: "Don't have an account?"),
                    ),
                  ),
                  Expanded(
                      child: CallToActionButton(
                    onPressed: onSignupPressed,
                    text: "Sign Up",
                    color: headerSignUpColor,
                  ))
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
