class Speaker {
  final String? imageUrl;
  final String name;

  Speaker({
    this.imageUrl,
    required this.name,
  });

  factory Speaker.fromJson(Map<String, dynamic> json) {
    return Speaker(
      imageUrl: json['imageUrl'] as String?,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'name': name,
    };
  }
}
