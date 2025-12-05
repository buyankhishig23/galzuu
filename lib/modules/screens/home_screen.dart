import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:galzuu/modules/model/games.dart';

import '../services/games_api_service.dart';
import '../widgets/category_selector.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Game>> _gamesFuture;
  final GamesApiService _apiService = GamesApiService();

  @override
  void initState() {
    super.initState();
    _gamesFuture = _apiService.fetchGames();
  }

  String? getDirectImgurUrl(String? url) {
    if (url == null || url.isEmpty) return null;
    if (url.contains('imgur.com') && !url.contains('i.imgur.com')) {
      final id = url.split('/').last.split('.').first;
      return 'https://i.imgur.com/$id.jpg';
    }
    return url;
  }

  Widget buildGameImage(String? url) {
    final directUrl = getDirectImgurUrl(url);

    return Image.network(
      directUrl ?? '',
      fit: BoxFit.cover,
      width: double.infinity,
      height: 180,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          width: double.infinity,
          height: 180,
          color: Colors.grey[800],
          child: const Center(
            child: CircularProgressIndicator(color: Colors.white70),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          'assets/images/1.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: 180,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: FutureBuilder<List<Game>>(
        future: _gamesFuture,
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
            final games = snapshot.data!;
            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final game = games[index];
                    final imageWidget = buildGameImage(game.img);

                    final blurredImage = ImageFiltered(
                      imageFilter: ImageFilter.blur(
                        sigmaX: index == 0 ? 0 : 2,
                        sigmaY: index == 0 ? 0 : 2,
                      ),
                      child: imageWidget,
                    );

                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: theme.scaffoldBackgroundColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                          ),
                          isScrollControlled: true,
                          builder: (context) {
                            return CategorySelector(
                              feedTitle: game.detail ?? 'Game',
                              confs: game.conf ?? [],
                              gameId: game.id ?? 0,
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
                              color: theme.colorScheme.surface.withValues(alpha: 0.6),
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                game.name ?? 'Game',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurface,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }, childCount: games.length),
                ),
              ],
            );
          } else {
            return Center(
              child: Text(
                'No games available',
                style: theme.textTheme.bodyMedium,
              ),
            );
          }
        },
      ),
    );
  }
}
