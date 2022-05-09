import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/advice.dart';

class ApiAdviceSlip {
  static Future<Advice> getRandomAdvice() async {
    const url = "https://api.adviceslip.com/advice";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Advice.fromJson(jsonDecode(response.body)['slip']);
    } else {
      throw Exception('Failed to load advice');
    }
  }

  static Future<Advice> getAdviceById(int id) async {
    final url = "https://api.adviceslip.com/advice/$id";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Advice.fromJson(jsonDecode(response.body)['slip']);
    } else {
      throw Exception('Failed to load advice');
    }
  }
}
