import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../models/conference_problem.model.dart';
import '../../../models/slot_type.enum.dart';

typedef OnProblemSelected = void Function(ConferenceProblem problem);

class CommandPanel extends StatefulWidget {
  final List<ConferenceProblem>? problems;
  final OnProblemSelected onProblemSelected;

  const CommandPanel(
      {Key? key, required this.problems, required this.onProblemSelected})
      : super(key: key);

  @override
  State<CommandPanel> createState() => _CommandPanelState();
}

class _CommandPanelState extends State<CommandPanel> {
  late String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.problems?[0].name;
  }

  String _pluralize(String single, String plural, int count) {
    return '$count ${count > 1 ? plural : single}';
  }

  String _computeComplexity(ConferenceProblem problem) {
    final allSlots = problem.days
        .expand((day) => day.tracks)
        .expand((track) => track.slots)
        .where((slot) => slot.type != SlotType.pause);

    final slotByType = groupBy(allSlots, (slot) => slot.type);
    final countBySlotType =
        slotByType.entries.fold(<SlotType, int>{}, (acc, entry) {
      acc[entry.key] = (acc[entry.key] ?? 0) + entry.value.length;
      return acc;
    });
    final complexity = countBySlotType.entries
        .map((entry) => entry.value)
        .toList()
        .fold(1, (total, count) => total * _tailRecursion(count));

    return 'Search space = ${complexity.toStringAsExponential(complexity > 100000 ? 0 : 2)} (${_pluralize('day', 'days', problem.days.length)}, ${_pluralize('track', 'tracks', problem.days.expand((day) => day.tracks).length)}, ${_pluralize('slot', 'slots', allSlots.length)})';
  }

  int _tailRecursion(int n) {
    if (n == 0) {
      return 1;
    } else {
      return n * _tailRecursion(n - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    const dayTitleHeight = 80.0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: widget.problems != null
          ? Container(
              constraints: const BoxConstraints(minHeight: 50),
              color: const Color(0xff252360),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 40,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Text('Problem:',
                          style:
                              TextStyle(color: Colors.white70, fontSize: 14)),
                    ),
                    DropdownButton<String>(
                      isDense: true,
                      value: _selectedValue,
                      icon: const Icon(Icons.arrow_downward,
                          color: Colors.white, size: 12),
                      elevation: 0,
                      dropdownColor: Colors.red,
                      style: const TextStyle(color: Colors.white),
                      onChanged: (String? value) {
                        setState(() {
                          _selectedValue = value!;
                          widget.onProblemSelected(widget.problems!.firstWhere(
                              (problem) => problem.name == _selectedValue));
                        });
                      },
                      items: widget.problems?.map((ConferenceProblem problem) {
                        final complexity = _computeComplexity(problem);
                        final List<String> parts = complexity.split('+');
                        return DropdownMenuItem<String>(
                          value: problem.name,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            child: RichText(
                              text: TextSpan(
                                  text: problem.name,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14),
                                  children: [
                                    TextSpan(
                                      text: ' - 10',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                    WidgetSpan(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Text(
                                          parts[1],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontFeatures: [
                                                FontFeature.superscripts()
                                              ]),
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                            /*
                            Text(

                                '${problem.name} - ${_computeComplexity(problem)}'),*/
                          ),
                        );
                      }).toList(),
                    ),
                    const Spacer()
                  ],
                ),
              ),
            )
          : const SizedBox(
              height: dayTitleHeight,
              child: Center(
                child: Text('Loading...'),
              ),
            ),
    );
  }
}
