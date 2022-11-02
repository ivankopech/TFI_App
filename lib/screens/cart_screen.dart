import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.headline6.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 100,
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, index) => CartItem(
                cart.items.values.toList()[index].id,
                cart.items.keys.toList()[index],
                cart.items.values.toList()[index].price,
                cart.items.values.toList()[index].quantity,
                cart.items.values.toList()[index].title,
              ),
            ),
          ),
          OrderButton(cart: cart),
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  TextEditingController _priceController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: _priceController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.attach_money_outlined),
            hintText: 'Ingrese precio',
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: _timeController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.watch_later_outlined),
            hintText: 'Ingrese tiempo',
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () async {
            var precio = _priceController.text;
            var tiempo = _timeController.text;
            await Provider.of<Orders>(context, listen: false).addOrder(
              widget.cart.items.values.toList(),
              widget.cart.totalAmount,
              double.parse(precio),
              int.parse(tiempo),
            );
            setState(() {
              _isLoading = false;
            });
            widget.cart.clear();
            print('enviado');
          },
          child: Text(
            'Enviar',
          ),
        ),
      ],
    );
  }
}
