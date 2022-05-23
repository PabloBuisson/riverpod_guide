class Advice {
  int? id;
  String advice;
  String? date;

  Advice({required this.id, required this.advice, this.date});

  factory Advice.fromJson(Map<String, dynamic> json) {
    return Advice(
      id: json['id'],
      advice: json['advice'],
      date: json['date'],
    );
  }
}
