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
      if (_currentIndex < _questions.length - 1) {
        _currentIndex++;
      }
    });
  }

  void _prev() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: FutureBuilder<List<Question>>(
          future: _questionsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.orange),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            } else if (snapshot.hasData) {
              _questions = snapshot.data!;
              if (_questions.isEmpty) {
                return const Center(
                  child: Text(
                    'No questions available',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              final currentQ = _questions[_currentIndex];

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // header
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(
                      "Хариул эсвэл уу",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),

                  // shuffle button
                  ElevatedButton(
                    onPressed: _shuffle,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Хөзөр холих"),
                  ),

                  // main card
                  Expanded(
                    child: Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.5,
                        decoration: BoxDecoration(
                          color: Colors.orange,
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
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
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

                  // navigation
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.yellow,
                          ),
                          onPressed: _prev,
                        ),
                        Text(
                          "${_currentIndex + 1}/${_questions.length}",
                          style: const TextStyle(color: Colors.white),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_forward,
                            color: Colors.yellow,
                          ),
                          onPressed: _next,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text(
                  'No questions found',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
