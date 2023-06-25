import 'package:flutter/material.dart';

import '../../../models/conference_problem.model.dart';
import 'day_column.dart';

class Planning extends StatelessWidget {
  final int hoursCells;
  final double hourHeight;
  final ConferenceProblem problem;

  const Planning(
      {Key? key,
      required this.hoursCells,
      required this.hourHeight,
      required this.problem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(width: 80),
        ...problem.days
            .map((day) => Expanded(
                  child: DayColumn(
                    day: day,
                    hoursCells: hoursCells,
                    hourHeight: hourHeight,
                  ),
                ))
            .toList(),
      ],
    );
  }
}
