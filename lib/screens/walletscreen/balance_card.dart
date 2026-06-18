import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  final String title;
  final String icon;

  const BalanceCard({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 141,
      height: 85,
      decoration: BoxDecoration(
        color: const Color(0xFF1A2152),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1546E8), width: 0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: Color(0xFF243A7A),
              shape: BoxShape.circle,
            ),
            child: Center(child: Image.asset(icon, width: 24, height: 24)),
          ),
          const SizedBox(width: 14),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: 'SFCompact',
            ),
          ),
        ],
      ),
    );
  }
}
