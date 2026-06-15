import 'package:flutter/material.dart';

class ShoppingCard extends StatelessWidget {
  final String title;
  final String date;
  final String amount;
  final bool isShoppig;

  const ShoppingCard({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    required this.isShoppig,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF19204A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 31,
            width: 31,
            child: Image.asset(
              isShoppig
                  ? "assets/images/shopping.png"
                  : "assets/images/receive.png",
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'SFCompact',
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Text(
                  date,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                    fontFamily: 'SFCompact',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              amount,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'SFCompact',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
