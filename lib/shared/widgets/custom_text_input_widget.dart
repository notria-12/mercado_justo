import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextInput extends StatefulWidget {
  String label;
  String? hintText;
  Icon? icon;
  List<TextInputFormatter>? inputFotmatters;
  TextInputType? inputType;
  final FormFieldValidator<String>? validator;
  final FormFieldValidator<String>? onSave;
  CustomTextInput(
      {Key? key,
      required this.label,
      this.hintText,
      this.icon,
      this.inputFotmatters,
      this.validator,
      this.inputType,
      this.onSave})
      : super(key: key);

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
          child: TextFormField(
            onSaved: widget.onSave,
            inputFormatters: widget.inputFotmatters,
            keyboardType: widget.inputType,
            validator: widget.validator,
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: InputBorder.none,
              prefixIcon: widget.icon,
            ),
          ),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        ),
      ],
    );
  }
}
