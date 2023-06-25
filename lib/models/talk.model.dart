import 'speaker.model.dart';

class Talk {
  final int id;
  final String title;
  final List<String> tags;
  final List<Speaker> speakers;
  final String description;

  Talk({
    required this.id,
    required this.title,
    required this.tags,
    required this.speakers,
    required this.description,
  });

  factory Talk.fromJson(Map<String, dynamic> json) {
    return Talk(
      id: json['id'] as int,
      title: json['title'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      speakers: (json['speakers'] as List<dynamic>)
          .map((e) => Speaker.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'tags': tags,
      'speakers': speakers.map((e) => e.toJson()).toList(),
      'description': description,
    };
  }
}
