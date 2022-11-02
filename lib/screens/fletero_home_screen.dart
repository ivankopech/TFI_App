import 'package:flutter/material.dart';

import '../widgets/fleteros_drawer.dart';

class FleteroHomeScreen extends StatefulWidget {
  static const routeName = '/fletero-home-screen';

  @override
  State<FleteroHomeScreen> createState() => _FleteroHomeScreenState();
}

class _FleteroHomeScreenState extends State<FleteroHomeScreen> {
  final logoImage = 'assets/images/transporte.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Principal'),
        backgroundColor: Colors.indigo,
      ),
      drawer: FleteroDrawer(),
      body: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 80)),
          Image.asset(
            logoImage,
            fit: BoxFit.cover,
          ),
          Text(
            'Bienvenido!',
            style: TextStyle(fontSize: 30),
          )
        ],
      ),
    );
  }
}
