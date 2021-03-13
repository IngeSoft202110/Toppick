import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 3.0, right: 3.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(
              Icons.menu,
              color: Colors.white,
              size: 50,
            ),
            Image.asset(
              'assets/img/logo.png',
              height: 85,
            ),
            Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white,
              size: 50,
            )
          ],
        ),
      ),
    );
  }
}
