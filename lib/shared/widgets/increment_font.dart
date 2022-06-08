import 'package:flutter/material.dart';

class IncrementFont extends StatelessWidget {
  const IncrementFont({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 35,
        width: 35,
        child: Center(
            child: Text(
          '+ A',
          style: TextStyle(color: Colors.lightBlue),
        )),
        decoration: BoxDecoration(
            color: const Color.fromRGBO(190, 235, 199, 1),
            borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}
