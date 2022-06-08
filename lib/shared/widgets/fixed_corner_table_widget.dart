import 'package:flutter/material.dart';
import 'package:mercado_justo/shared/widgets/button_share.dart';
import 'package:mercado_justo/shared/widgets/increment_font.dart';

class FixedCorner extends StatelessWidget {
  const FixedCorner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [const IncrementFont(), ButtonShare()],
    );
  }
}
