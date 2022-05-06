import 'dart:async';

class ApiAdviceSlip {
  static Future<String> getRandomAdvice() async {
    // https://api.adviceslip.com/advice
    return Future.value('');
  }

  static Future<String> getAdviceById(String id) async {
    // https://api.adviceslip.com/advice/{slip_id}
    return Future.value('');
  }
}
