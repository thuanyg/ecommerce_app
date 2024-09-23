import 'package:flutter/material.dart';

Widget MainElevatedButton(
    {double width = 320,
    double height = 58,
    String textButton = "",
    Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(15),
    child: Container(
      clipBehavior: Clip.antiAlias,
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.lightGreen,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          textButton,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}
