import 'package:flexibledashboard/models/advice.dart';
import 'package:flexibledashboard/services/api_adviceslip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvicesScreen extends StatelessWidget {
  AdvicesScreen({Key? key}) : super(key: key);

  final adviceRandomProvider = FutureProvider<Advice>((ref) async {
    return ApiAdviceSlip.getRandomAdvice();
  });

  final adviceIdProvider =
      FutureProvider.family<Advice, String>((ref, id) async {
    return ApiAdviceSlip.getAdviceById(id);
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Advices")),
      body: Column(
        children: const [Text("Random advice"), Text("Advice by id")],
      ),
    );
  }
}
