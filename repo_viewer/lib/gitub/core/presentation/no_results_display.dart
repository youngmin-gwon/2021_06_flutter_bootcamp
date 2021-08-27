import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NoResultsDisplay extends StatelessWidget {
  const NoResultsDisplay({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(MdiIcons.emoticonPoop, size: 96),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5,
          )
        ],
      ),
    );
  }
}
