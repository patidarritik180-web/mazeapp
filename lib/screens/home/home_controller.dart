import 'package:get/get.dart';
import 'package:maze_app/screens/home/widgets/transaction_model.dart';

class HomeController extends GetxController {
  // Portfolio
  RxDouble balance = 41000.0.obs;
  RxDouble profit = 19.25.obs;

  // Market Data
  RxString marketCap = "780,091".obs;
  RxString btcDominance = "32.11%".obs;
  RxString cryptoCount = "30903".obs;

  // Transactions
  RxList<TransactionModel> transactions = <TransactionModel>[
    TransactionModel(
      title: "Received",
      date: "January 10, 2001",
      amount: "+0.991 ETH",
      isReceived: true,
    ),
    TransactionModel(
      title: "Withdrawn",
      date: "January 10, 2001",
      amount: "-0.991 ETH",
      isReceived: false,
    ),
    TransactionModel(
      title: "Received",
      date: "January 12, 2001",
      amount: "+1.250 BTC",
      isReceived: true,
    ),
  ].obs;

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

  // Add Transaction
  void addTransaction(TransactionModel transaction) {
    transactions.add(transaction);
  }
}
