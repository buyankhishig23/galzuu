import 'dart:math';

import 'package:flutter/material.dart';
import 'package:galzuu/modules/model/Question.dart';

import '../services/question_api_service.dart';

class QuestionScreen extends StatefulWidget {
  final int gameId;
  final String type;
  final int? confId;

  const QuestionScreen({
    super.key,
    required this.gameId,
    required this.type,
    this.confId,
  });

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late Future<List<Question>> _questionsFuture;
  final QuestionsApiService _apiService = QuestionsApiService();

  int _currentIndex = 0;
  List<Question> _questions = [];

  @override
  void initState() {
    super.initState();
    _questionsFuture = _apiService.fetchQuestions(
      gameId: widget.gameId,
      confId: widget.confId!,
    );
  }

  void _shuffle() {
    setState(() {
      _questions.shuffle(Random());
      _currentIndex = 0;
    });
  }

  void _next() {
    setState(() {
      if (_currentIndex < _questions.length - 1) _currentIndex++;
    });
  }

  void _prev() {
    setState(() {
      if (_currentIndex > 0) _currentIndex--;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: FutureBuilder<List<Question>>(
          future: _questionsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: theme.colorScheme.secondary,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: theme.textTheme.bodyMedium,
                ),
              );
            } else if (snapshot.hasData) {
              _questions = snapshot.data!;
              if (_questions.isEmpty) {
                return Center(
                  child: Text(
                    'No questions available',
                    style: theme.textTheme.bodyMedium,
                  ),
                );
              }

              final currentQ = _questions[_currentIndex];

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context); // go back to previous screen
                      },
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: "Хариул ",
                              style: TextStyle(
                                color: theme.colorScheme.secondary,
                              ),
                            ),
                            TextSpan(
                              text: "эсвэл ",
                              style: TextStyle(
                                color: theme.colorScheme.onPrimary,
                              ),
                            ),
                            TextSpan(
                              text: "уу",
                              style: TextStyle(
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: _shuffle,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 24,
                        horizontal: 32,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.shuffle, color: theme.colorScheme.onPrimary),
                        SizedBox(width: 8), // space between icon and text
                        Text(
                          "Хөзөр холих",
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.5,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondary,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (currentQ.img != null &&
                                    currentQ.img!.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 12.0,
                                    ),
                                    child: Image.network(
                                      currentQ.img!,
                                      fit: BoxFit.contain,
                                      height: 150,
                                    ),
                                  ),
                                Text(
                                  currentQ.question ?? '',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.onSecondary,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Back button (flipped)
                        IconButton(
                          iconSize: 50,
                          icon: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(
                              pi,
                            ), // flip horizontally
                            child: Image.asset(
                              'assets/images/right-arrow.png',
                              height: 60,
                              width: 100,
                            ),
                          ),
                          onPressed: _prev,
                        ),

                        // Current question index
                        Text(
                          "${_currentIndex + 1}/${_questions.length}",
                          style: theme.textTheme.bodyMedium,
                        ),

                        // Next button
                        IconButton(
                          iconSize: 50,
                          icon: Image.asset(
                            'assets/images/right-arrow.png',
                            height: 60,
                            width: 100,
                          ),
                          onPressed: _next,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text(
                  'Асуулт олдсонгүй',
                  style: theme.textTheme.bodyMedium,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
