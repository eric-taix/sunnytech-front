import 'package:conf_scheduling_front/models/slot_type.enum.dart';
import 'package:equatable/equatable.dart';

class Slot implements Equatable {
  final String id;
  final double start;
  final double end;
  final List<String> tags;
  final SlotType type;
  final int size;

  const Slot({
    required this.id,
    required this.start,
    required this.end,
    required this.tags,
    required this.type,
    required this.size,
  });

  double get duration => end - start;

  factory Slot.fromJson(Map<String, dynamic> json) {
    double parseHour(String time) {
      final parts = time.split(':');
      return double.parse(parts[0]) + double.parse(parts[1]) / 60;
    }

    return Slot(
      id: json['id'],
      start: parseHour(json['start']),
      end: parseHour(json['end']),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      type: parseSlotType((json['type'])),
      size: json['size'] ?? 1,
    );
  }

  Map<String, Object> toJson() {
    return {
      'id': id,
      'start': start,
      'end': end,
      'tags': tags,
    };
  }

  @override
  List<Object?> get props => [start, end, tags, type];

  @override
  bool? get stringify => true;
}

extension SlotExtension on Slot {
  double computeHeight(double hourHeight) {
    return duration * hourHeight;
  }
}
