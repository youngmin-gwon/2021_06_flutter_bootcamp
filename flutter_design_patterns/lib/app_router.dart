import 'package:flutter/material.dart';

import 'data/models/design_pattern.dart';
import 'pages/design_pattern_details/design_pattern_details_page.dart';
import 'pages/main_menu/main_menu_page.dart';
import 'widgets/design_patterns/index.dart';

class AppRouter {
  static const mainMenuPageRoute = '/';

  const AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainMenuPageRoute:
        return MaterialPageRoute(
          builder: (_) => const MainMenuPage(),
        );
      case _DesignPatternRoutes.singletonRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const SingletonExample(),
        );
      case _DesignPatternRoutes.adapterRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const AdapterExample(),
        );
      case _DesignPatternRoutes.templateMethodRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const TemplateMethodExample(),
        );
      case _DesignPatternRoutes.compositeRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const CompositeExample(),
        );
      case _DesignPatternRoutes.strategyRoute:
        return _buildDesignPatternDetailsPageRoute(
          settings,
          const StrategyExample(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const MainMenuPage(),
        );
    }
  }

  static MaterialPageRoute _buildDesignPatternDetailsPageRoute(
    RouteSettings settings,
    Widget example,
  ) {
    final designPattern = settings.arguments! as DesignPattern;

    return MaterialPageRoute(
      builder: (_) => DesignPatternDetailsPage(
        designPattern: designPattern,
        example: example,
      ),
    );
  }
}

class _DesignPatternRoutes {
  static const String abstractFactoryRoute = '/abstract-factory';
  static const String adapterRoute = '/adapter';
  static const String bridgeRoute = '/bridge';
  static const String builderRoute = '/builder';
  static const String chainOfResponsibilityRoute = '/chain-of-responsibility';
  static const String commandRoute = '/command';
  static const String compositeRoute = '/composite';
  static const String decoratorRoute = '/decorator';
  static const String facadeRoute = '/facade';
  static const String factoryMethodRoute = '/factory-method';
  static const String flyweightRoute = '/flyweight';
  static const String interpreterRoute = '/interpreter';
  static const String introductionRoute = '/introduction';
  static const String iteratorRoute = '/iterator';
  static const String mediatorRoute = '/mediator';
  static const String mementoRoute = '/memento';
  static const String observerRoute = '/observer';
  static const String prototypeRoute = '/prototype';
  static const String proxyRoute = '/proxy';
  static const String singletonRoute = '/singleton';
  static const String stateRoute = '/state';
  static const String strategyRoute = '/strategy';
  static const String templateMethodRoute = '/template-method';
  static const String visitorRoute = '/visitor';
}