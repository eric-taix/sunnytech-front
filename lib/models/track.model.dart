import 'package:equatable/equatable.dart';

import 'slot.model.dart';

class Track implements Equatable {
  final String room;
  final List<Slot> slots;
  final List<String> tags;

  const Track({
    required this.room,
    required this.slots,
    required this.tags,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      room: json['room'] as String,
      slots: (json['slots'] as List<dynamic>)
          .map((e) => Slot.fromJson(e as Map<String, dynamic>))
          .toList(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
    );
  }

  Map<String, Object> toJson() {
    return {
      'room': room,
      'slots': slots.map((e) => e.toJson()).toList(),
      'tags': tags,
    };
  }

  @override
  List<Object?> get props => [room, slots, tags];

  @override
  bool? get stringify => true;
}
