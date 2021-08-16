import 'package:flutter/material.dart';
import 'package:flutter_design_patterns/constants/layout_constants.dart';

import 'package:flutter_design_patterns/design_patterns/strategy/order/order_item.dart';

class OrderItemsTable extends StatelessWidget {
  const OrderItemsTable({
    Key? key,
    required this.orderItems,
  }) : super(key: key);

  final List<OrderItem> orderItems;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: LayoutConstants.spaceL,
      horizontalMargin: LayoutConstants.marginM,
      headingRowHeight: LayoutConstants.spaceXL,
      dataRowHeight: LayoutConstants.spaceXL,
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            "Title",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
          ),
        ),
        DataColumn(
          label: Text(
            "Package Size",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
          ),
        ),
        DataColumn(
            label: Text(
              "Price",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
            ),
            numeric: true),
      ],
      rows: <DataRow>[
        for (var orderItem in orderItems)
          DataRow(cells: [
            DataCell(Text(orderItem.title)),
            DataCell(Text(orderItem.packageSize.toString().split('.').last)),
            DataCell(Text("\$${orderItem.price.toStringAsFixed(2)}")),
          ])
      ],
    );
  }
}
