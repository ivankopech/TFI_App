import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

class UserHomeScreen extends StatefulWidget {
  static const routeName = '/user-home-screen';

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final logoImage = 'assets/images/transporte.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu principal'),
        backgroundColor: Colors.indigo,
      ),
      drawer: AppDrawer(),
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
