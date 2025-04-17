import 'package:flutter/material.dart';

class MenuItems extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;

  const MenuItems({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16,
          bottom: 16,
          left: 28,
          right: 28,
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.cyan, size: 30),
            SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 23,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
