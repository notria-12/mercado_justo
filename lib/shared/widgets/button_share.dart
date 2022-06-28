import 'package:flutter/material.dart';

class ButtonShare extends StatelessWidget {
  double size;
  ButtonShare({Key? key, this.size = 28}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      icon: Icon(
        Icons.share_outlined,
        color: Colors.grey,
        size: size,
      ),
      onPressed: () {},
    );
  }
}
