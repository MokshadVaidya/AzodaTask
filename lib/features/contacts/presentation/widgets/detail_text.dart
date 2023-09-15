import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';

class CustomDetailText extends StatelessWidget {
  const CustomDetailText({
    super.key,
    required this.name,
    this.textStyle = kdetailedTextStyle,
  });

  final String name;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kTextSpacing),
      child: Text(
        name,
        style: textStyle,
      ),
    );
  }
}