import 'package:flutter/material.dart';

import '../providers/orders.dart' as ord;

class AnotherOrderItem extends StatefulWidget {
  final ord.OrderItem order;

  AnotherOrderItem(this.order);

  @override
  State<AnotherOrderItem> createState() => _AnotherOrderItemState();
}

class _AnotherOrderItemState extends State<AnotherOrderItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListView(
        children: widget.order.products
            .map(
              (prod) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    prod.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${prod.quantity}x \$${prod.price}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
