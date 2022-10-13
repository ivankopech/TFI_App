import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

class UserHomeScreen extends StatefulWidget {
  static const routeName = '/user-home-screen';

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('usuarios'),
      ),
      drawer: AppDrawer(),
    );
  }
}
