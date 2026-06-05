import 'package:get/get.dart';

class HomeController extends GetxController {
  // -------------------------
  // Portfolio Data
  // -------------------------
  RxDouble balance = 41000.0.obs;
  RxDouble profit = 19.25.obs;

  // -------------------------
  // Marquee / Market Data
  // (you can later replace with API)
  // -------------------------
  RxString marketCap = "780,091".obs;
  RxString btcDominance = "32.11%".obs;
  RxString cryptoCount = "30903".obs;

  // -------------------------
  // Actions (for testing)
  // -------------------------
  void addProfit(double value) {
    balance.value += value;
    profit.value += value;
  }

  void resetPortfolio() {
    balance.value = 41000.0;
    profit.value = 19.25;
  }

  void updateMarketData({
    required String cap,
    required String dominance,
    required String count,
  }) {
    marketCap.value = cap;
    btcDominance.value = dominance;
    cryptoCount.value = count;
  }
}
