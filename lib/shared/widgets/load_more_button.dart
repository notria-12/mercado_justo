import 'package:flutter/material.dart';

class LoadMoreButton extends StatelessWidget {
  VoidCallback loadMoreItens;
  LoadMoreButton({
    Key? key,
    required this.loadMoreItens,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loadMoreItens,
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.blueAccent)),
        height: 40,
        child: Icon(
          Icons.add,
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}
