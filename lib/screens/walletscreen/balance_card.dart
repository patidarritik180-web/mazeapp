import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  final String title;
  final String icon;

  const BalanceCard({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 141,
      //  height: 85,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2152),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFF1546E8), width: 0.5),
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),

          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Color(0xFF243A7A),
              shape: BoxShape.circle,
            ),
            child: Center(child: Image.asset(icon, width: 18, height: 18)),
          ),

          const SizedBox(width: 12),

          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'SFCompact',
            ),
          ),
        ],
      ),
    );
  }
}
