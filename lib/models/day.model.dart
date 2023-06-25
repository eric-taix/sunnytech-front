import 'package:conf_scheduling_front/models/track.model.dart';
import 'package:equatable/equatable.dart';

class Day implements Equatable {
  final DateTime date;
  final List<Track> tracks;

  Day({
    required this.date,
    required this.tracks,
  });

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      date: DateTime.parse(json['date'] as String),
      tracks: (json['tracks'] as List<dynamic>)
          .map((e) => Track.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, Object?> toJson() {
    return {
      'date': date.toIso8601String(),
      'tracks': tracks.map((e) => e.toJson()).toList(),
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [date, tracks];

  @override
  bool? get stringify => true;
}
