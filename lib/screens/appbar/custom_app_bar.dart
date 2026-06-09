import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Image(
          image: AssetImage('assets/images/Menu.png'),
          width: 26,
          height: 26,
        ),

        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            fontFamily: 'SFCompact',
          ),
        ),

        const Image(
          image: AssetImage('assets/images/Notification.png'),
          width: 26,
          height: 26,
        ),
      ],
    );
  }
}
