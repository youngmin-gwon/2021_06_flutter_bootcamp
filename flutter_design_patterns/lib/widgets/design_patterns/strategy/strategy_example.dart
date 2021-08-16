import 'package:flutter/material.dart';
import 'package:flutter_design_patterns/constants/layout_constants.dart';
import 'package:flutter_design_patterns/design_patterns/strategy/i_shipping_cost_strategy.dart';
import 'package:flutter_design_patterns/design_patterns/strategy/order/order.dart';
import 'package:flutter_design_patterns/design_patterns/strategy/order/order_item.dart';
import 'package:flutter_design_patterns/design_patterns/strategy/strategies/in_store_pickup_strategy.dart';
import 'package:flutter_design_patterns/design_patterns/strategy/strategies/parcel_terminal_shipping_strategy.dart';
import 'package:flutter_design_patterns/design_patterns/strategy/strategies/priority_shipping_strategy.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/strategy/order/order_buttons/order_buttons.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/strategy/order/order_items_table.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/strategy/order/order_summary/order_summary.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/strategy/shipping_options.dart';

class StrategyExample extends StatefulWidget {
  const StrategyExample({Key? key}) : super(key: key);

  @override
  _StrategyExampleState createState() => _StrategyExampleState();
}

class _StrategyExampleState extends State<StrategyExample> {
  final List<IShippingCostsStrategy> _shippingCostsStrategyList = [
    InStorePickupStrategy(),
    ParcelTerminalShippingStrategy(),
    PriorityShippingStrategy(),
  ];

  int _selectedStrategyIndex = 0;
  Order _order = Order();

  void _addToOrder() {
    setState(() {
      _order.addOrderItem(OrderItem.random());
    });
  }

  void _clearOrder() {
    setState(() {
      _order = Order();
    });
  }

  void _setSelectedStrategyIndex(int? index) {
    setState(() {
      _selectedStrategyIndex = index!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
        behavior: const ScrollBehavior(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: LayoutConstants.paddingL,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OrderButtons(onAdd: _addToOrder, onClear: _clearOrder),
              const SizedBox(height: LayoutConstants.spaceM),
              Stack(
                children: [
                  AnimatedOpacity(
                    opacity: _order.items.isEmpty ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Your order is empty",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: _order.items.isEmpty ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 500),
                    child: Column(
                      children: [
                        OrderItemsTable(orderItems: _order.items),
                        const SizedBox(height: LayoutConstants.spaceM),
                        ShippingOptions(
                          shippingOptions: _shippingCostsStrategyList,
                          selectedIndex: _selectedStrategyIndex,
                          onChanged: _setSelectedStrategyIndex,
                        ),
                        OrderSummary(
                          order: _order,
                          shippingCostsStrategy: _shippingCostsStrategyList[
                              _selectedStrategyIndex],
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
