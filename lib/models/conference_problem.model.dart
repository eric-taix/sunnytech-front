import 'package:equatable/equatable.dart';

import 'day.model.dart';
import 'talk.model.dart';

class ConferenceProblem implements Equatable {
  final String name;
  final List<Day> days;
  final List<Talk> talks;

  ConferenceProblem({
    required this.name,
    required this.days,
    required this.talks,
  });

  factory ConferenceProblem.fromJson(Map<String, dynamic> json) {
    return ConferenceProblem(
      name: json['name'] as String,
      days: (json['days'] as List<dynamic>)
          .map((e) => Day.fromJson(e as Map<String, dynamic>))
          .toList(),
      talks: (json['talks'] as List<dynamic>)
          .map((e) => Talk.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'days': days.map((e) => e.toJson()).toList(),
      'talks': talks.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [name, days, talks];

  @override
  bool? get stringify => true;
}
