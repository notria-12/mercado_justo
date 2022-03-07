import 'package:flutter/material.dart';

class CustomTextInput extends StatefulWidget {
  String label;
  String hintText;
  Icon icon;
  CustomTextInput({
    Key? key,
    required this.label,
    required this.hintText,
    required this.icon,
  }) : super(key: key);

  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 45,
          child: TextFormField(
            decoration: InputDecoration(
                hintText: widget.hintText,
                border: InputBorder.none,
                prefixIcon: widget.icon),
          ),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        ),
      ],
    );
  }
}
