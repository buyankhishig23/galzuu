import 'dart:ui';

import 'package:flutter/material.dart';

import '../widgets/category_selector.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> feeds = [
      {
        "image": "assets/images/1.png",
        "title": "Хариул эсвэл уух уу?",
        "categories": ["Game", "Drink", "Challenge"],
      },
      {
        "image": "assets/images/2.png",
        "title": "Харилцан эсвэл Зориг",
        "categories": ["Truth", "Dare", "Fun"],
      },
      {
        "image": "assets/images/3.png",
        "title": "Үнэн эсвэл Хий (Truth or Dare)",
        "categories": ["Truth", "Dare"],
      },
      {
        "image": "assets/images/4.png",
        "title": "Би хэзээ ч...",
        "categories": ["Never", "Maybe"],
      },
      {
        "image": "assets/images/5.png",
        "title": "Хэн нь магадгүй вэ?",
        "categories": ["Most Likely", "Guess"],
      },
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final feed = feeds[index];
              final imageWidget = Image.asset(
                feed["image"]!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 180,
              );
              final blurredImage =
                  index == 0
                      ? imageWidget
                      : ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: imageWidget,
                      );

              return GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    isScrollControlled: true,
                    builder: (context) {
                      return CategorySelector(
                        feedTitle: feed["title"]!,
                        feedImage: feed["image"]!,
                        categories: List<String>.from(feed["categories"]),
                      );
                    },
                  );
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      blurredImage,
                      Container(
                        width: double.infinity,
                        color: Colors.black54,
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          feed["title"]!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }, childCount: feeds.length),
          ),
        ],
      ),
    );
  }
}
