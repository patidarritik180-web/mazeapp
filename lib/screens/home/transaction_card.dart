import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final String title;
  final String date;
  final String amount;
  final bool isReceived;

  const TransactionCard({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    required this.isReceived,
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
          // 🔥 ICON (GREEN / RED)
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Color.fromRGBO(17, 22, 57, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isReceived ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              color: isReceived ? Colors.green : Colors.red,
              size: 40,
            ),
          ),

          const SizedBox(width: 12),

          // TEXT PART
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
               // const SizedBox(height: 2),
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

          // AMOUNT COLOR CHANGE
          Text(
            amount,
            style: TextStyle(
              color: isReceived ? Colors.green : Colors.red,
              fontFamily: 'SFCompact',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
