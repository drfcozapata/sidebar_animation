import 'package:flutter/material.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';

class MyAccountPage extends NavigationStates {
  MyAccountPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'My Account Page',
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
      ),
    );
  }
}
