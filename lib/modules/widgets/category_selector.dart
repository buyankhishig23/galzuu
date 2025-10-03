import 'package:flutter/material.dart';
import 'package:galzuu/modules/model/Games.dart';

import '../screens/question_screen.dart';

class CategorySelector extends StatelessWidget {
  final String feedTitle;
  final int gameId;
  final List<Conf> confs;

  const CategorySelector({
    super.key,
    required this.feedTitle,
    required this.gameId,
    required this.confs,
  });

  String getType(Conf conf) {
    if ((conf.type ?? '').isNotEmpty) return conf.type!;
    if (gameId == 1) return 'normal';
    if (gameId == 2) return '21';
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            feedTitle,
            style: theme.textTheme.titleLarge?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: confs.length,
              separatorBuilder: (_, __) => const SizedBox(height: 20),
              itemBuilder: (context, index) {
                final conf = confs[index];
                final type = getType(conf);

                return SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                    onPressed:
                        type.isEmpty
                            ? null
                            : () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => QuestionScreen(
                                        gameId: gameId,
                                        type: type,
                                        confId: conf.id, // ✅ id дамжууллаа
                                      ),
                                ),
                              );
                            },
                    child: Text(
                      conf.value ?? '',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
