import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ButtonShare extends StatelessWidget {
  double size;
  void Function()? onPressed;
  ButtonShare({Key? key, this.size = 28, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      icon: Icon(
        Icons.share_outlined,
        color: Colors.grey,
        size: size,
      ),
      onPressed: onPressed,
    );
  }
}
