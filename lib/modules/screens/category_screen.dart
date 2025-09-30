import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  final String feedTitle;
  final String category;

  const CategoryScreen({
    super.key,
    required this.feedTitle,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    // Sample questions with images
    final List<Map<String, String>> questions = [
      {"image": "assets/images/1.png", "question": "This is question 1"},
      {"image": "assets/images/2.png", "question": "This is question 2"},
      {"image": "assets/images/3.png", "question": "This is question 3"},
    ];

    return Scaffold(
      appBar: AppBar(title: Text("$category - $feedTitle")),
      body: PageView.builder(
        itemCount: questions.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final q = questions[index];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                // Optional: tap to go next
                if (index < questions.length - 1) {
                  // Scroll to next page
                  PageController controller = PageController(
                    initialPage: index,
                  );
                  controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                clipBehavior: Clip.antiAlias,
                color: Colors.blueGrey.shade900,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Image part (fills most of card)
                    Expanded(
                      flex: 3,
                      child: Image.asset(q["image"]!, fit: BoxFit.cover),
                    ),
                    // Question part (big text)
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        color: Colors.black87,
                        child: Center(
                          child: Text(
                            q["question"]!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
