import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maze_app/screens/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(() => const HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset('assets/images/Shad.png')),
          Center(
            child: Image(
              image: AssetImage('assets/images/mazelogo.png'),
              width: 100,
              height: 123.72881317138672,
            ),
          ),
        ],
      ),
    );
  }
}
