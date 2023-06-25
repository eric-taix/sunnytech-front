import 'hard_soft_score.model.dart';
import 'slot.model.dart';
import 'talk.model.dart';

class ConferenceSolution {
  final List<Slot> slots;
  final List<String> rooms;
  final List<Talk> talks;
  final HardSoftScore score;

  ConferenceSolution({
    required this.slots,
    required this.rooms,
    required this.talks,
    required this.score,
  });

  factory ConferenceSolution.fromJson(Map<String, dynamic> json) {
    return ConferenceSolution(
      slots: (json['slots'] as List<dynamic>)
          .map((e) => Slot.fromJson(e as Map<String, dynamic>))
          .toList(),
      rooms: (json['rooms'] as List<dynamic>).map((e) => e as String).toList(),
      talks: (json['talks'] as List<dynamic>)
          .map((e) => Talk.fromJson(e as Map<String, dynamic>))
          .toList(),
      score: HardSoftScore.fromJson(json['score'] as Map<String, dynamic>),
    );
  }
}
