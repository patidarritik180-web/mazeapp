import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maze_app/screens/home/newsscreen/news_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final PageController _pageController = PageController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020B3F),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Image.asset(
                        'assets/images/back.png',
                        height: 18,
                        width: 18,
                      ),
                    ),
                    Text(
                      "News",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'SFCompact',
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/saved.png',
                          height: 22,
                          width: 22,
                        ),

                        SizedBox(width: 7),

                        Icon(
                          Icons.search_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                SizedBox(
                  height: 177,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: 3,
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              "assets/images/newsbg.jpg",
                              width: double.infinity,
                              height: 177,
                              fit: BoxFit.cover,
                            ),
                          ),

                          Container(
                            height: 177,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  const Color(0xFF191F3F).withOpacity(0.8),
                                ],
                              ),
                            ),
                          ),

                          Positioned(
                            left: 20,
                            right: 20,
                            bottom: 15,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "CRYPTOCURRENCY",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'SFCompact',
                                  ),
                                ),

                                const SizedBox(height: 6),

                                const Text(
                                  "Coinbase says hackers stole cryptocurrency from at least 6,000 customers",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'SFCompact',
                                  ),
                                ),

                                const SizedBox(height: 10),

                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "www.bloomber.com",
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 12,
                                      fontFamily: 'SFCompact',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                const SizedBox(height: 15),

                SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    activeDotColor: const Color(0xFF0041E7),
                    dotColor: const Color(0xFF9CB8FF),
                    dotHeight: 8,
                    dotWidth: 8,
                    expansionFactor: 3,
                    spacing: 6,
                  ),
                ),

                const SizedBox(height: 20),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const NewsCard(
                      image: "assets/images/list.jpg",
                      title:
                          "Emerging market 'cryptoization' threatens financial stability: IMF",
                      source: "www.clooma.com",
                      time: "Just now / 2mins ago",
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
