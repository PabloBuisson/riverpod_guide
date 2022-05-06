class Advice {
  late final int id;
  late final String advice;
  late final String? date;

  Advice({required this.id, required this.advice, this.date});

  factory Advice.fromJson(Map<String, dynamic> json) {
    return Advice(
      id: json['id'],
      advice: json['advice'],
      date: json['date'],
    );
  }
}
