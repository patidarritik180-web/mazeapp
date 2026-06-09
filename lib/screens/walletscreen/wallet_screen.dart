import 'package:flutter/material.dart';
import 'package:maze_app/screens/appbar/custom_app_bar.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020B3F),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 20),

                const CustomAppBar(title: "Exchange Market"),

                const SizedBox(height: 20),
                Container(height: 10, width: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
