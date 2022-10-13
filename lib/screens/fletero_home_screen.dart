import 'package:flutter/material.dart';

import '../widgets/fleteros_drawer.dart';

class FleteroHomeScreen extends StatefulWidget {
  static const routeName = '/fletero-home-screen';

  @override
  State<FleteroHomeScreen> createState() => _FleteroHomeScreenState();
}

class _FleteroHomeScreenState extends State<FleteroHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('fleteros'),
      ),
      drawer: FleteroDrawer(),
    );
  }
}
