class HardSoftScore {
  final int hardScore;
  final int softScore;

  HardSoftScore({
    required this.hardScore,
    required this.softScore,
  });

  factory HardSoftScore.fromJson(Map<String, dynamic> json) {
    return HardSoftScore(
      hardScore: json['hardScore'] as int,
      softScore: json['softScore'] as int,
    );
  }
}
