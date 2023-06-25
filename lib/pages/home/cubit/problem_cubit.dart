import 'package:conf_scheduling_front/rest/rest_client.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/conference_problem.model.dart';

part 'problem_state.dart';

class ProblemCubit extends Cubit<ProblemState> {

  final RestClient _restClient;

  ProblemCubit(this._restClient) : super(ProblemInitial());

  Future<void> loadProblems() async {
    emit(ProblemLoading());
    final problems = await _restClient.requestProblems();
    emit(ProblemLoaded(problems));
  }

  void selectProblem(ConferenceProblem problem) {
    if (state is ProblemLoaded) {
      emit(ProblemLoaded((state as ProblemLoaded).problems,
          selectedProblem: problem));
    }
  }
}
