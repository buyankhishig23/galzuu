import 'package:dio/dio.dart';
import 'package:galzuu/modules/init/dio_manager.dart';
import 'package:galzuu/modules/model/Question.dart';

class QuestionsApiService {
  final Dio _dio = DioManager.instance.dio;

  Future<List<Question>> fetchQuestions({
    required int gameId,
    required int confId, // ⚡ conf.id дамжуулна
  }) async {
    try {
      final response = await _dio.get(
        '/questions/$gameId',
        queryParameters: {'type': confId},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Question.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch questions: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to fetch questions: ${e.message}');
    }
  }
}
