import 'package:flutter/material.dart';

class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(50),
      child: CircleAvatar(
        radius: 24,
        backgroundColor: const Color(0xfff4f4f4),
        child: Image.asset("assets/images/ic_heart.png"),
      ),
    );
  }
}
