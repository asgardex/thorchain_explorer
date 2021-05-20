import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NavigationItem extends StatelessWidget {
  final bool isActive;
  final String title;
  final String navigationRoute;
  final IconData? iconData;

  NavigationItem(
      {this.isActive = false,
      this.title = '',
      this.navigationRoute = '',
      this.iconData});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, navigationRoute),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Row(
            children: [
              Icon(
                iconData,
                color: isActive ? Colors.white : Colors.grey,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                title,
                style: TextStyle(color: isActive ? Colors.white : Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
