import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  String scanResult = "";

  MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020B3F),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(height: 60),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset(
                    'assets/images/back.png',
                    height: 15,
                    width: 15,
                  ),
                ),
                Text(
                  "Scanner",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'SFCompact',
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset(
                    'assets/images/Notification.png',
                    height: 20,
                    width: 20,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Text(
              "Align QR Code within the frame area to scan.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'SFCompact',
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: MobileScanner(
                controller: cameraController,

                onDetect: (capture) {
                  final List<Barcode> barcodes = capture.barcodes;

                  for (final barcode in barcodes) {
                    setState(() {
                      scanResult = barcode.rawValue ?? "No Data";
                    });

                    print(scanResult);
                  }
                },
              ),
            ),
            const SizedBox(height: 30),
            Text(
              "Scanning will start automatically.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'SFCompact',
              ),
            ),
            const SizedBox(height: 100),

            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF545E53),
                minimumSize: const Size(120, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text(
                "Cancle",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.all(20),

              child: Text(scanResult, style: const TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
