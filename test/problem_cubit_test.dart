import 'package:conf_scheduling_front/models/conference_problem.model.dart';
import 'package:conf_scheduling_front/models/conference_solution.model.dart';
import 'package:conf_scheduling_front/models/day.model.dart';
import 'package:conf_scheduling_front/models/talk.model.dart';
import 'package:conf_scheduling_front/pages/home/cubit/problem_cubit.dart';
import 'package:conf_scheduling_front/rest/rest_client.dart';
import 'package:flutter_test/flutter_test.dart';

class MockRestClient extends RestClient {
  @override
  Future<List<ConferenceProblem>> requestProblems() {
    return Future.delayed(
        const Duration(milliseconds: 50),
        () => [
              ConferenceProblem(
                name: 'confname',
                days: [Day(date: DateTime(2023, 4, 23), tracks: [])],
                talks: [
                  Talk(
                      id: 1,
                      title: 't1',
                      tags: [],
                      speakers: [],
                      description: '')
                ],
              ),
            ]);
  }

  @override
  Future<ConferenceSolution> solutionOf(int id) {
    // TODO: implement solutionOf
    throw UnimplementedError();
  }

  @override
  Future<int> solve(ConferenceProblem problem) {
    // TODO: implement solve
    throw UnimplementedError();
  }
}

void main() {
  group('Conference Cubit', () {
    test('should emit ProblemLoaded when loadProblems is called', () async {
      final cubit = ProblemCubit(MockRestClient());
      await cubit.loadProblems();
      expect(cubit.state, isA<ProblemLoaded>());
    });
    test(
        'should emit ProblemLoaded with selected problem when selectProblem is called',
        () async {
      final cubit = ProblemCubit(MockRestClient());
      await cubit.loadProblems();
      expect(cubit.state, isA<ProblemLoaded>());
      final problems = (cubit.state as ProblemLoaded).problems;
      expect(
          problems,
          containsAllInOrder([
            ConferenceProblem(
              name: 'confname',
              days: [Day(date: DateTime(2023, 4, 23), tracks: [])],
              talks: [
                Talk(
                    id: 1, title: 't1', tags: [], speakers: [], description: '')
              ],
            )
          ]));
    });
  });
}
