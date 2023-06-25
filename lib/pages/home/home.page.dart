import 'package:conf_scheduling_front/pages/home/widgets/command_panel.dart';
import 'package:conf_scheduling_front/pages/home/widgets/planning.dart';
import 'package:conf_scheduling_front/rest/rest_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/conference_problem.model.dart';
import 'cubit/problem_cubit.dart';
import 'widgets/hour.dart';

class HomePage extends StatefulWidget {
  static const startHour = 8.0;
  static const endHour = 19.0;

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ProblemCubit _problemCubit;

  @override
  void initState() {
    super.initState();
    _problemCubit = ProblemCubit(RestClientImpl())..loadProblems();
  }

  @override
  void dispose() {
    _problemCubit.close();
    super.dispose();
  }

  _onProblemSelected(ConferenceProblem problem) {
    _problemCubit.selectProblem(problem);
  }

  @override
  Widget build(BuildContext context) {
    final hoursCells = (HomePage.endHour - HomePage.startHour).toInt();
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Center(
        child: BlocBuilder<ProblemCubit, ProblemState>(
          bloc: _problemCubit,
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                CommandPanel(
                    onProblemSelected: _onProblemSelected,
                    problems: state is ProblemLoaded ? state.problems : null),
                Expanded(
                  child: LayoutBuilder(builder: (context, constraints) {
                    final hourHeight = (constraints.maxHeight / hoursCells);
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ...List.generate(
                          hoursCells + 1,
                          (index) => Positioned(
                            top: index * hourHeight - 20,
                            left: 0,
                            child: Hour(
                              hour: index + HomePage.startHour.toInt(),
                              hourHeight: hourHeight,
                            ),
                          ),
                        ),
                        state is ProblemLoaded
                            ? (state.selectedProblem != null
                                ? Planning(
                                    problem: state.selectedProblem!,
                                    hoursCells: hoursCells,
                                    hourHeight: hourHeight)
                                : const Center(
                                    child: Text(
                                        'Select a problem to start planning'),
                                  ))
                            : const Center(child: CircularProgressIndicator()),
                      ],
                    );
                  }),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
