import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/advice.dart';
import '../services/api_adviceslip.dart';

class AdvicesScreen extends ConsumerWidget {
  AdvicesScreen({Key? key}) : super(key: key);

  // FutureProvider is the equivalent of Provider (readonly) but for asynchronous code
  // FutureProvider does not offer a way of directly modifying the computation
  // after a user interaction. It is designed to solve simple use-cases.
  // For more advanced scenarios, consider using StateNotifierProvider
  final adviceRandomProvider = FutureProvider<Advice>((ref) async {
    return ApiAdviceSlip.getRandomAdvice();
  });

  // with the family modifier provider, we can add a parameter to the provider
  // The way families works is by adding an extra parameter to the provider
  // PREFER using autoDispose when the parameter is not constant
  final adviceByIdProvider =
      FutureProvider.autoDispose.family<Advice, int>((ref, id) async {
    return ApiAdviceSlip.getAdviceById(id);
  });

  // create a randomNumber to use with the adviceByIdProvider
  final int randomNumber = Random().nextInt(225); // from 0 up to 224 included
  // (numbers of advices available)

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Future Provider ↓
    final AsyncValue<Advice> adviceRandom = ref.watch(adviceRandomProvider);
    // 💡 with family, we need to pass an argument to the provider
    final AsyncValue<Advice> adviceRandomId =
        ref.watch(adviceByIdProvider(randomNumber));

    return Scaffold(
      appBar: AppBar(title: const Text("Advices")),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Random advice",
              textAlign: TextAlign.center,
              textScaleFactor: 1.4,
            ),
            AdviceBlock(advice: adviceRandom),
            const SizedBox(
              height: 50,
            ),
            Text(
              "Advice with id $randomNumber",
              textAlign: TextAlign.center,
              textScaleFactor: 1.4,
            ),
            AdviceBlock(advice: adviceRandomId),
          ],
        ),
      ),
    );
  }
}

class AdviceBlock extends StatelessWidget {
  const AdviceBlock({Key? key, required this.advice}) : super(key: key);

  final AsyncValue<Advice> advice;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          border:
              const Border(left: BorderSide(color: Colors.grey, width: 5.0))),
      child: Text(
        advice.when(
            data: (Advice value) => value.advice,
            error: (Object error, _) =>
                "A problem occurred, please try again later",
            loading: () => "Loading..."),
        textAlign: TextAlign.center,
        style: const TextStyle(fontStyle: FontStyle.italic),
      ),
    );
  }
}
