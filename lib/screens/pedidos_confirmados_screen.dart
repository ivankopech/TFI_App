import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/another_order_item.dart';
import '../widgets/app_drawer.dart';

class PedidosConfirmadosScreen extends StatefulWidget {
  static const routeName = '/pedidos-confirmados';

  @override
  State<PedidosConfirmadosScreen> createState() =>
      _PedidosConfirmadosScreenState();
}

class _PedidosConfirmadosScreenState extends State<PedidosConfirmadosScreen> {
  Future _ordersFuture;

  Future _obtainOrdersFuture() {
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  @override
  void initState() {
    _ordersFuture = _obtainOrdersFuture();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedidos'),
        backgroundColor: Colors.indigo,
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _ordersFuture,
        // ignore: missing_return
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapshot.error != null) {
              // do error handling
              return Center(
                child: Text('an error ocurred'),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (ctx, index) =>
                      AnotherOrderItem(orderData.orders[index], orderData),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
