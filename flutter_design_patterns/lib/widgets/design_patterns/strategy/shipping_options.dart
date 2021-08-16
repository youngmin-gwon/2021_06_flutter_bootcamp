import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/design_patterns/strategy/i_shipping_cost_strategy.dart';

class ShippingOptions extends StatelessWidget {
  const ShippingOptions({
    Key? key,
    required this.shippingOptions,
    required this.selectedIndex,
    required this.onChanged,
  }) : super(key: key);

  final List<IShippingCostsStrategy> shippingOptions;
  final int selectedIndex;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(
            "Select shipping type:",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          for (var i = 0; i < shippingOptions.length; i++)
            RadioListTile(
              title: Text(shippingOptions[i].label),
              value: i,
              groupValue: selectedIndex,
              onChanged: onChanged,
              dense: true,
              activeColor: Colors.black,
            )
        ],
      ),
    );
  }
}
