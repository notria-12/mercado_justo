import 'package:flutter/material.dart';

class ButtonProfileOptions extends StatelessWidget {
  String label;
  VoidCallback onTap;
  ButtonProfileOptions({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 240, 241, 241),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.black38)),
        height: 50,
        width: 300,
        child: Center(
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
