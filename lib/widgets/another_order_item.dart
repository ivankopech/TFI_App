// import 'package:flutter/material.dart';

// import '../providers/orders.dart' as ord;

// class AnotherOrderItem extends StatefulWidget {
//   final ord.OrderItem order;

//   AnotherOrderItem(this.order);

//   @override
//   State<AnotherOrderItem> createState() => _AnotherOrderItemState();
// }

// class _AnotherOrderItemState extends State<AnotherOrderItem> {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(10),
//       child: ListView(
//         children: widget.order.products
//             .map(
//               (prod) => Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Text(
//                     prod.title,
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     '${prod.quantity}x \$${prod.price}',
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             )
//             .toList(),
//       ),
//     );
//   }
// }

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' as ord;

class AnotherOrderItem extends StatefulWidget {
  final ord.OrderItem order;
  final ord.Orders orderActions;

  AnotherOrderItem(this.order, this.orderActions);

  @override
  _AnotherOrderItemState createState() => _AnotherOrderItemState();
}

class _AnotherOrderItemState extends State<AnotherOrderItem> {
  var _expanded = false;
  var id;

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<ord.Orders>(context);
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.car_crash_outlined,
          color: Colors.white,
          size: 30,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Pedido finalizado?'),
            content: Text('Si o no?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  //Provider.of<ord.Orders>(context).deleteOrder(id);
                  widget.orderActions.clear();
                },
                child: Text('Si'),
              ),
              FlatButton(
                onPressed: () {
                  widget.orderActions.clear();
                  //Provider.of<ord.Orders>(context).deleteOrder(id);
                },
                child: Text('No'),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        //Provider.of<ord.Orders>(context).
      },
      child: Container(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: _expanded
              ? min(widget.order.products.length * 20.0 + 110.0, 200.0)
              : 95,
          child: Card(
            margin: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text('Abrir para ver detalle'),
                  subtitle: Text(
                    DateFormat('dd MM yyyy hh:mm')
                        .format(widget.order.dateTime),
                  ),
                  trailing: IconButton(
                    icon:
                        Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                    onPressed: () {
                      setState(() {
                        _expanded = !_expanded;
                      });
                    },
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: _expanded
                      ? min(widget.order.products.length * 20.0 + 18.0, 100.0)
                      : 0,
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 2,
                  ),
                  child: ListView(
                    children: widget.order.products
                        .map(
                          (prod) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Producto: ' + prod.title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '\$${widget.order.presupPrice} a enviar en ${widget.order.presupTime} dias',
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
