import 'package:flutter/material.dart';

class OrderSummaryRow extends StatelessWidget {
  const OrderSummaryRow({
    Key? key,
    required this.label,
    required this.value,
    required this.fontFamily,
  }) : super(key: key);

  final String label;
  final double value;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        label,
        style: Theme.of(context).textTheme.subtitle1!.copyWith(
              fontFamily: fontFamily,
            ),
      ),
      Text(
        "\$${value.toStringAsFixed(2)}",
        style: Theme.of(context).textTheme.subtitle1!.copyWith(
              fontFamily: fontFamily,
            ),
      )
    ]);
  }
}
