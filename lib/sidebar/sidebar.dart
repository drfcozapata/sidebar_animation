import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';
import '../sidebar/menu_items.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  late AnimationController _animationController;
  late StreamController<bool> isSidebarOpenedStreamController;
  late Stream<bool> isSidebarOpenedStream;
  late StreamSink<bool> isSidebarOpenedSink;
  final _animationDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSidebarOpenedAsync) {
        final isSidebarOpened = isSidebarOpenedAsync.data ?? false;
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSidebarOpened ? 0 : -screenWidth,
          right: isSidebarOpened ? 0 : screenWidth - 40,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Color(0xFF262AAA),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 93),
                      ListTile(
                        title: Text(
                          'Francisco',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        subtitle: Text(
                          'drfcozapata@gmail.com',
                          style: TextStyle(
                            color: Color(0xFF1BB5FD),
                            fontSize: 15,
                          ),
                        ),
                        leading: CircleAvatar(
                          radius: 40,
                          child: Icon(Icons.perm_identity, color: Colors.white),
                        ),
                      ),
                      Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Colors.white30,
                        indent: 28,
                        endIndent: 28,
                      ),
                      Column(
                        children: [
                          MenuItems(
                            icon: Icons.home,
                            title: 'Home',
                            onTap: () {
                              onIconPressed();
                              BlocProvider.of<NavigationBloc>(
                                context,
                              ).add(NavigationEvents.homePageClickedEvent);
                            },
                          ),
                          MenuItems(
                            icon: Icons.person,
                            title: 'My Account',
                            onTap: () {
                              onIconPressed();
                              BlocProvider.of<NavigationBloc>(
                                context,
                              ).add(NavigationEvents.myAccountClickedEvent);
                            },
                          ),
                          MenuItems(
                            icon: Icons.shopping_basket_rounded,
                            title: 'My Orders',
                            onTap: () {
                              onIconPressed();
                              BlocProvider.of<NavigationBloc>(
                                context,
                              ).add(NavigationEvents.myOrdersClickedEvent);
                            },
                          ),
                          MenuItems(
                            icon: Icons.card_giftcard,
                            title: 'Wishlist',
                            onTap: () {},
                          ),
                          Divider(
                            height: 64,
                            thickness: 0.5,
                            color: Colors.white30,
                            indent: 28,
                            endIndent: 28,
                          ),
                          MenuItems(
                            icon: Icons.settings,
                            title: 'Setting',
                            onTap: () {},
                          ),
                          MenuItems(
                            icon: Icons.exit_to_app,
                            title: 'Logout',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, -0.8),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 35,
                      height: 110,
                      color: const Color(0xFF262AAA),
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: const Color(0xFF1BB5FD),
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width - 4;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 8, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 6, 0, height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
