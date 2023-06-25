part of 'problem_cubit.dart';

@immutable
abstract class ProblemState implements Equatable {
  @override
  bool? get stringify => true;
}

class ProblemInitial extends ProblemState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ProblemLoading extends ProblemState {
  @override
  List<Object?> get props => [];
}

class ProblemLoaded extends ProblemState {
  final ConferenceProblem? selectedProblem;
  final List<ConferenceProblem> problems;

  ProblemLoaded(this.problems, {this.selectedProblem});

  @override
  List<Object?> get props => [selectedProblem, problems];
}
