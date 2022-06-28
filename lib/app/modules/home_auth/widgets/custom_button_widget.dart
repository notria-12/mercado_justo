import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  String label;
  Widget? subTitle;
  VoidCallback onPressed;

  CustomButtom({
    required this.label,
    required this.onPressed,
    this.subTitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 300,
      child: ElevatedButton(
        child: subTitle != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                  subTitle!
                ],
              )
            : Center(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22),
                ),
              ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            primary: Colors.lightBlue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      ),
    );
  }
}
