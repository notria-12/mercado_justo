import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputProfile extends StatefulWidget {
  String label;
  String? hintText;
  Icon? icon;
  TextEditingController? controller;
  Function(String)? onChange;
  String? initialValue;
  List<TextInputFormatter>? inputFormatters;
  TextInputType? inputType;
  CustomInputProfile(
      {Key? key,
      required this.label,
      this.hintText,
      this.icon,
      this.controller,
      this.onChange,
      this.initialValue,
      this.inputFormatters,
      this.inputType})
      : super(key: key);

  @override
  State<CustomInputProfile> createState() => _CustomInputProfileState();
}

class _CustomInputProfileState extends State<CustomInputProfile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black54),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.all(8),
          height: 40,
          child: TextFormField(
            initialValue: widget.initialValue,
            inputFormatters: widget.inputFormatters,
            keyboardType: widget.inputType,
            controller: widget.controller,
            onChanged: widget.onChange,
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: InputBorder.none,
              prefixIcon: widget.icon,
            ),
          ),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4)),
        ),
      ],
    );
  }
}
