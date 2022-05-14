import 'package:flutter/material.dart';

class FixedCorner extends StatelessWidget {
  const FixedCorner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
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
        ),
        IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(
            Icons.share_outlined,
            color: Colors.grey,
            size: 28,
          ),
          onPressed: () {},
        )
      ],
    );
  }
}
