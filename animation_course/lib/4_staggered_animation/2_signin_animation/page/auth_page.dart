import 'dart:ui';

import 'package:animation_course/0_widgets/widgets.dart';
import 'package:animation_course/4_staggered_animation/2_signin_animation/page/home_page.dart';
import 'package:animation_course/4_staggered_animation/2_signin_animation/utils/fade_route.dart';
import 'package:animation_course/4_staggered_animation/2_signin_animation/widgets/expanding_page_animation.dart';
import 'package:animation_course/4_staggered_animation/2_signin_animation/widgets/forms/login_form.dart';
import 'package:animation_course/4_staggered_animation/2_signin_animation/widgets/forms/signup_form.dart';
import 'package:animation_course/4_staggered_animation/2_signin_animation/widgets/headers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
import 'package:simple_animations/simple_animations.dart';

enum AuthState {
  login,
  signup,
  home,
}

enum AnimationProps {
  scale,
  width,
  height,
  headerHeight,
  borderRadius,
}

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<TimelineValue<AnimationProps>> _animation;
  late SequenceAnimation _sequenceAnimation;

  double _expandingWidth = 0;
  double _expandingHeight = 0;
  double _expandingBorderRadius = 500;

  static const double _pannelWidth = 350;
  static const double _pannelHeight = 500;
  static const double _headerHeight = 60;
  static const double _borderRadius = 30;

  bool _isLogin = true;
  AuthState _authState = AuthState.login;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..addStatusListener(_animationStatusListener);

    // _initSequenceAnimation();

    _initTimelineAnimation();
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.dismissed) {
      if (_authState == AuthState.home) {
        _setHomeState();
        return;
      }

      _controller.forward(from: 0);

      if (_authState == AuthState.login) {
        _setLoginState(true);
        return;
      }
      if (_authState == AuthState.signup) {
        _setLoginState(false);
      }
    }
  }

  void _setHomeState() {
    setState(() {
      _expandingHeight = MediaQuery.of(context).size.height;
      _expandingWidth = MediaQuery.of(context).size.width;
      _expandingBorderRadius = 0;
      _routeTransition();
    });
  }

  void _setLoginState(bool isLogin) {
    setState(() {
      _isLogin = isLogin;
    });
  }

  void _onPressed(AuthState state) {
    _controller.reverse();
    _authState = state;
  }

  void _initSequenceAnimation() {
    _sequenceAnimation = SequenceAnimationBuilder()
        // SCALE
        .addAnimatable(
            animatable: Tween<double>(begin: 0, end: 1),
            from: const Duration(milliseconds: 600),
            to: const Duration(milliseconds: 1200),
            curve: Curves.easeIn,
            tag: 'scale')
        // PANNEL WIDTH
        .addAnimatable(
            animatable: Tween<double>(begin: 0, end: _headerHeight),
            from: const Duration(milliseconds: 0),
            to: const Duration(milliseconds: 300),
            curve: Curves.ease,
            tag: 'width')
        .addAnimatable(
            animatable: Tween<double>(begin: _headerHeight, end: _pannelWidth),
            from: const Duration(milliseconds: 300),
            to: const Duration(milliseconds: 600),
            curve: Curves.ease,
            tag: 'width')
        // PANNEL HEIGHT
        .addAnimatable(
            animatable: Tween<double>(begin: 0, end: _headerHeight),
            from: const Duration(milliseconds: 0),
            to: const Duration(milliseconds: 300),
            curve: Curves.ease,
            tag: 'height')
        .addAnimatable(
            animatable: Tween<double>(begin: _headerHeight, end: _pannelHeight),
            from: const Duration(milliseconds: 700),
            to: const Duration(milliseconds: 1200),
            curve: Curves.linear,
            tag: 'height')
        // HEADER HEIGHT
        .addAnimatable(
            animatable: Tween<double>(begin: 0, end: _headerHeight),
            from: const Duration(milliseconds: 0),
            to: const Duration(milliseconds: 300),
            curve: Curves.ease,
            tag: 'headerHight')
        .addAnimatable(
            animatable: Tween<double>(
                begin: _headerHeight,
                end: (_pannelHeight - _headerHeight) / 2 + _headerHeight),
            from: const Duration(milliseconds: 700),
            to: const Duration(milliseconds: 950),
            curve: Curves.linear,
            tag: 'headerHight')
        .addAnimatable(
            animatable: Tween<double>(
                begin: (_pannelHeight - _headerHeight) / 2 + _headerHeight,
                end: _headerHeight),
            from: const Duration(milliseconds: 950),
            to: const Duration(milliseconds: 1200),
            curve: Curves.ease,
            tag: 'headerHight')
        // BORDER RADIUS
        .addAnimatable(
            animatable: BorderRadiusTween(
              begin: BorderRadius.circular(0),
              end: BorderRadius.circular(_borderRadius),
            ),
            from: const Duration(milliseconds: 0),
            to: const Duration(milliseconds: 600),
            curve: Curves.ease,
            tag: 'borderRadius')
        .animate(_controller);
  }

  void _initTimelineAnimation() {
    final tween = TimelineTween<AnimationProps>()
      ..addScene(
        begin: const Duration(milliseconds: 600),
        end: const Duration(milliseconds: 1200),
        curve: Curves.easeIn,
      ).animate(AnimationProps.scale, tween: Tween<double>(begin: 0, end: 1))
      ..addScene(
        begin: const Duration(milliseconds: 0),
        end: const Duration(milliseconds: 300),
        curve: Curves.ease,
      ).animate(AnimationProps.width,
          tween: Tween<double>(begin: 0, end: _headerHeight))
      ..addScene(
        begin: const Duration(milliseconds: 300),
        end: const Duration(milliseconds: 600),
        curve: Curves.ease,
      ).animate(AnimationProps.width,
          tween: Tween<double>(begin: _headerHeight, end: _pannelWidth))
      ..addScene(
        begin: const Duration(milliseconds: 0),
        end: const Duration(milliseconds: 300),
        curve: Curves.ease,
      ).animate(AnimationProps.height,
          tween: Tween<double>(begin: 0, end: _headerHeight))
      ..addScene(
        begin: const Duration(milliseconds: 700),
        end: const Duration(milliseconds: 1200),
        curve: Curves.linear,
      ).animate(AnimationProps.height,
          tween: Tween<double>(begin: _headerHeight, end: _pannelHeight))
      ..addScene(
        begin: const Duration(milliseconds: 0),
        end: const Duration(milliseconds: 300),
        curve: Curves.ease,
      ).animate(
        AnimationProps.headerHeight,
        tween: Tween<double>(begin: 0, end: _headerHeight),
      )
      ..addScene(
        begin: const Duration(milliseconds: 700),
        end: const Duration(milliseconds: 950),
        curve: Curves.linear,
      ).animate(
        AnimationProps.headerHeight,
        tween: Tween<double>(
            begin: _headerHeight,
            end: (_pannelHeight - _headerHeight) / 2 + _headerHeight),
      )
      ..addScene(
        begin: const Duration(milliseconds: 950),
        end: const Duration(milliseconds: 1200),
        curve: Curves.ease,
      ).animate(AnimationProps.headerHeight,
          tween: Tween<double>(
              begin: (_pannelHeight - _headerHeight) / 2 + _headerHeight,
              end: _headerHeight))
      ..addScene(
        begin: const Duration(milliseconds: 0),
        end: const Duration(milliseconds: 600),
        curve: Curves.ease,
      ).animate(
        AnimationProps.borderRadius,
        tween: BorderRadiusTween(
          begin: BorderRadius.circular(0),
          end: BorderRadius.circular(_borderRadius),
        ),
      );

    _animation = tween.animate(_controller);
  }

  Future<void> _routeTransition() {
    return Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.pushReplacement<dynamic, dynamic>(
        context,
        FadeRoute(
          child: const HomePage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: backgroundAuthDecoration(),
          child: Stack(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints.expand(),
                child: const FlutterLogo(
                  textColor: Colors.blueGrey,
                  style: FlutterLogoStyle.markOnly,
                ),
              ),
              Center(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, body) {
                    return ClipRRect(
                      clipBehavior: Clip.antiAlias,
                      borderRadius: BorderRadius.circular(_borderRadius),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Container(
                          height: _animation.value.get(AnimationProps.height),
                          width: _animation.value.get(AnimationProps.width),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300.withOpacity(.1),
                            borderRadius: _animation.value
                                .get(AnimationProps.borderRadius),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: body,
                              ),
                              Header(
                                  scale: _animation.value
                                      .get(AnimationProps.scale),
                                  height: _animation.value
                                      .get(AnimationProps.headerHeight),
                                  isLogin: _isLogin),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: _isLogin
                      ? LoginForm(
                          onSignupPressed: () {
                            _onPressed(AuthState.signup);
                          },
                          onLoginPressed: () {
                            _onPressed(AuthState.home);
                          },
                          safeArea: _headerHeight)
                      : SignUpForm(
                          onLoginPressed: () {
                            _onPressed(AuthState.login);
                          },
                          onSignupPressed: () {
                            _onPressed(AuthState.home);
                          },
                          safeArea: _headerHeight),
                ),
              ),
              ExpandingPageAnimation(
                width: _expandingWidth,
                height: _expandingHeight,
                borderRadius: _expandingBorderRadius,
              )
            ],
          )),
    );
  }
}
