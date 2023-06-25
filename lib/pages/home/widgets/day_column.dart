import 'package:conf_scheduling_front/models/day.model.dart';
import 'package:conf_scheduling_front/pages/home/widgets/slot_card.dart';
import 'package:flutter/material.dart';

class DayColumn extends StatelessWidget {
  final Day day;
  final int hoursCells;
  final double hourHeight;

  const DayColumn(
      {Key? key,
      required this.day,
      required this.hoursCells,
      required this.hourHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: Color(0xffAD29DB), width: 3)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0),
        child: LayoutBuilder(builder: (context, constraints) {
          final slotWidth = constraints.maxWidth / day.tracks.length;
          return Stack(
            children: [
              ...day.tracks
                  .asMap()
                  .map(
                    (index, track) {
                      return MapEntry(index, track.slots.map((slot) {
                        return SlotCard(
                          key: ValueKey(slot.id),
                          slot: slot,
                          hourHeight: hourHeight,
                          left: index * slotWidth,
                          width: slotWidth * slot.size,
                        );
                      }));
                    },
                  )
                  .values
                  .expand((element) => element),
            ],
          );
        }),
      ),
    );
  }
}
