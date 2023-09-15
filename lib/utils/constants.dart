import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const Color kPrimaryColor = Color.fromARGB(255, 6, 56, 97);
TextStyle kHeadTextStyle = TextStyle(
  fontSize: 40.sp,
  fontWeight: FontWeight.w900,
);
TextStyle kSubHeadTextStyle = TextStyle(
  fontSize: 20.sp,
  fontWeight: FontWeight.w500,
);
const TextStyle kdetailedTextStyle = TextStyle(
  color: Colors.grey,
);

double kDefaultPadding = 16.0.r;
double kTextSpacing = 8.0.r;
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
