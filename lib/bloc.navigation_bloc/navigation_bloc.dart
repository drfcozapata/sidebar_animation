import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../pages/home_page.dart';
import '../pages/my_account_page.dart';
import '../pages/my_orders_page.dart';

enum NavigationEvents {
  homePageClickedEvent,
  myAccountClickedEvent,
  myOrdersClickedEvent,
}

abstract class NavigationStates {
  Widget build(BuildContext context);
}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  NavigationBloc() : super(HomePage()) {
    on<NavigationEvents>((event, emit) {
      switch (event) {
        case NavigationEvents.homePageClickedEvent:
          emit(HomePage());
          break;
        case NavigationEvents.myAccountClickedEvent:
          emit(MyAccountPage());
          break;
        case NavigationEvents.myOrdersClickedEvent:
          emit(MyOrdersPage());
          break;
      }
    });
  }
}
