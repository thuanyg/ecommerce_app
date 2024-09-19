import 'package:flutter/material.dart';

class BackPrevScreen extends StatelessWidget {
  const BackPrevScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      borderRadius: BorderRadius.circular(50),
      child: CircleAvatar(
        radius: 24,
        backgroundColor: const Color(0xfff4f4f4),
        child: RotationTransition(
          turns: const AlwaysStoppedAnimation(90 / 360),
          child: Image.asset("assets/images/ic_dropdown.png"),
        ),
      ),
    );
  }
}
