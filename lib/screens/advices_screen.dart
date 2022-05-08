import 'package:flexibledashboard/models/advice.dart';
import 'package:flexibledashboard/services/api_adviceslip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvicesScreen extends ConsumerWidget {
  AdvicesScreen({Key? key}) : super(key: key);

  final adviceRandomProvider = FutureProvider<Advice>((ref) async {
    return ApiAdviceSlip.getRandomAdvice();
  });

  final adviceByIdProvider =
      FutureProvider.family<Advice, int>((ref, id) async {
    return ApiAdviceSlip.getAdviceById(id);
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Future Provider ↓
    final AsyncValue<Advice> adviceRandom = ref.watch(adviceRandomProvider);
    final AsyncValue<Advice> adviceById = ref.watch(adviceByIdProvider(1));

    return Scaffold(
      appBar: AppBar(title: const Text("Advices")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Random advice"),
          Text(
            adviceRandom.when(
                data: (Advice value) => value.advice,
                error: (Object error, _) =>
                    "A problem occurred, please try again later",
                loading: () => "Loading..."),
          ),
          ElevatedButton(
              onPressed: () {}, child: const Text("Get a new random advice")),
          const Text("Advice by id"),
          Text(
            adviceById.when(
                data: (Advice value) => value.advice,
                error: (Object error, _) =>
                    "A problem occurred, please try again later",
                loading: () => "Loading..."),
          ),
          ElevatedButton(
              onPressed: () {
                ApiAdviceSlip.getAdviceById(2);
              },
              child: const Text("Get an advice with id")),
        ],
      ),
    );
  }
}
