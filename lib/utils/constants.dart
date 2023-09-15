import 'package:flutter/material.dart';

const Color kPrimaryColor = Color.fromARGB(255, 6, 56, 97);
const TextStyle kHeadTextStyle = TextStyle(
  fontSize: 40,
  fontWeight: FontWeight.w900,
);
const TextStyle kSubHeadTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w500,
);
const TextStyle kdetailedTextStyle = TextStyle(
  color: Colors.grey,
);

const double kDefaultPadding = 16.0;
const double kTextSpacing = 8.0;
BoxDecoration kBoxDecoration = BoxDecoration(
    color: Colors.grey[300],
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
          color: Colors.grey.shade500,
          offset: const Offset(4, 4),
          blurRadius: 15,
          spreadRadius: 1),
      const BoxShadow(
          color: Colors.white,
          offset: Offset(-4, -4),
          blurRadius: 15,
          spreadRadius: 1),
    ]);
