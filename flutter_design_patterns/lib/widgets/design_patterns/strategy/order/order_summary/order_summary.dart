import 'package:flutter/material.dart';
import 'package:flutter_design_patterns/constants/layout_constants.dart';

import 'package:flutter_design_patterns/design_patterns/strategy/i_shipping_cost_strategy.dart';
import 'package:flutter_design_patterns/design_patterns/strategy/order/order.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/strategy/order/order_summary/order_summary_row.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({
    Key? key,
    required this.order,
    required this.shippingCostsStrategy,
  }) : super(key: key);

  final Order order;
  final IShippingCostsStrategy shippingCostsStrategy;

  double get shippingPrice => shippingCostsStrategy.calculate(order);
  double get total => order.price + shippingPrice;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(LayoutConstants.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order summary",
              style: Theme.of(context).textTheme.headline6,
            ),
            const Divider(),
            OrderSummaryRow(
                label: "Subtotal", value: order.price, fontFamily: "Roboto"),
            const SizedBox(height: LayoutConstants.spaceM),
            OrderSummaryRow(
                label: "Shipping", value: shippingPrice, fontFamily: "Roboto"),
            const Divider(),
            OrderSummaryRow(
                label: "Total", value: total, fontFamily: "RobotoMedium"),
          ],
        ),
      ),
    );
  }
}
