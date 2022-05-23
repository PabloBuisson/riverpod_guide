import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/animal.dart';

class ApiZooAnimals {
  static const baseUrl = "https://zoo-animal-api.herokuapp.com/animals/rand";

  static Future<Animal> getRandomAnimal() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      return Animal.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load animal');
    }
  }

  static Future<List<Animal>> getRandomAnimals(int number) async {
    final url = "$baseUrl/$number";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Iterable json = jsonDecode(response.body);
      return List<Animal>.from(json.map((model) => Animal.fromJson(model)));
    } else {
      throw Exception(
          'Failed to load animals from $baseUrl/$number = ${response.statusCode}');
    }
  }
}
