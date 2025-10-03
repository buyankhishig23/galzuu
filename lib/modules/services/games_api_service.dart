import 'package:dio/dio.dart';
import 'package:galzuu/modules/init/dio_manager.dart';
import 'package:galzuu/modules/model/Games.dart';

class GamesApiService {
  final Dio _dio = DioManager.instance.dio;

  // Бүх тоглоомуудыг татах
  Future<List<Game>> fetchGames() async {
    try {
      final response = await _dio.get(
        '/games/all',
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Game.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch games: Status ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to fetch games: ${e.message}');
    }
  }

  // Нэг тоглоомын дэлгэрэнгүй
  Future<Game> fetchGameById(int id) async {
    try {
      final response = await _dio.get(
        '/games/$id',
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        return Game.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch game: Status ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to fetch game: ${e.message}');
    }
  }

  // Шинэ тоглоом нэмэх
  Future<Game> createGame(Game game) async {
    try {
      final response = await _dio.post(
        '/games',
        data: game.toJson(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return Game.fromJson(response.data);
      } else {
        throw Exception('Failed to create game: Status ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to create game: ${e.message}');
    }
  }

  // Тоглоом шинэчлэх
  Future<Game> updateGame(int id, Game game) async {
    try {
      final response = await _dio.put(
        '/games/$id',
        data: game.toJson(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        return Game.fromJson(response.data);
      } else {
        throw Exception('Failed to update game: Status ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to update game: ${e.message}');
    }
  }

  // Тоглоом устгах
  Future<void> deleteGame(int id) async {
    try {
      final response = await _dio.delete(
        '/games/$id',
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Failed to delete game: Status ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to delete game: ${e.message}');
    }
  }
}
