import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.validator,
  });
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
      child: TextFormField(
        decoration:
            InputDecoration(label: Text(label), labelStyle: kSubHeadTextStyle),
        controller: controller,
        keyboardType: keyboardType, 
        textInputAction: textInputAction, 
        validator: validator,
        maxLines: null,
      ),
    );
  }
}
