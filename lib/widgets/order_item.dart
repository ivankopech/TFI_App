import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;
  final ord.Orders orderActions;

  OrderItem(this.order, this.orderActions);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
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
            title: Text('Que queres hacer?'),
            content: Text('aceptar o rechazar?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  //Provider.of<ord.Orders>(context).deleteOrder(id);
                  widget.orderActions.clear();
                },
                child: Text('Aceptar'),
              ),
              FlatButton(
                onPressed: () {
                  widget.orderActions.clear();
                  //Provider.of<ord.Orders>(context).deleteOrder(id);
                },
                child: Text('Rechazar'),
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
