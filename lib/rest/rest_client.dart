import 'package:dio/dio.dart';

import '../models/conference_problem.model.dart';
import '../models/conference_solution.model.dart';

final dio = Dio()..options.baseUrl = 'http://localhost:8080/api';

abstract class RestClient {
  Future<List<ConferenceProblem>> requestProblems();

  Future<int> solve(ConferenceProblem problem);

  Future<ConferenceSolution> solutionOf(int id);
}

class RestClientImpl implements RestClient {
  @override
  Future<List<ConferenceProblem>> requestProblems() async {
    Response response;
    response = await dio.get('/problems');
    if (response.statusCode != 200) {
      throw Exception('Error: ${response.statusCode}');
    }
    return (response.data as List)
        .map((jsonElement) =>
            ConferenceProblem.fromJson(jsonElement as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<int> solve(ConferenceProblem problem) async {
    Response response;
    response = await dio.post('/solve', data: problem.toJson());
    if (response.statusCode != 200) {
      throw Exception('Error: ${response.statusCode}');
    }
    return response.data as int;
  }

  @override
  Future<ConferenceSolution> solutionOf(int id) async {
    Response response;
    response = await dio.get('/solutions/$id');
    if (response.statusCode != 200) {
      throw Exception('Error: ${response.statusCode}');
    }
    return ConferenceSolution.fromJson(response.data as Map<String, dynamic>);
  }
}
