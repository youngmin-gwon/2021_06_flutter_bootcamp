import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/constants/layout_constants.dart';

class SingletonExampleCard extends StatelessWidget {
  const SingletonExampleCard({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 64.0,
        padding: const EdgeInsets.all(LayoutConstants.paddingL),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
