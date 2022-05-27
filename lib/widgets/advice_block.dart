import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/advice.dart';

class AdviceBlock extends StatelessWidget {
  const AdviceBlock({Key? key, required this.advice}) : super(key: key);

  final AsyncValue<Advice> advice;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          border:
              const Border(left: BorderSide(color: Colors.grey, width: 6.0))),
      child: Text(
        advice.when(
            data: (Advice value) => value.advice,
            error: (Object error, _) =>
                "A problem occurred, please try again later",
            loading: () => "Loading..."),
        textAlign: TextAlign.center,
        textScaleFactor: 1.3,
        style: const TextStyle(fontStyle: FontStyle.italic),
      ),
    );
  }
}
