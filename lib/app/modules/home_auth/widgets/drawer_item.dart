import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  Widget child;
  VoidCallback? onTap;
  DrawerItem({Key? key, required this.child, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            width: double.maxFinite,
            child: child,
          ),
        ),
        // const Divider(),
      ],
    );
  }
}
