import 'package:flutter/material.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';

class MyOrdersPage extends NavigationStates {
  MyOrdersPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'My Orders Page',
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
      ),
    );
  }
}
