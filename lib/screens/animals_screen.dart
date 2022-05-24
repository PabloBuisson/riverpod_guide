import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main.dart';
import '../models/animal.dart';

class AnimalsScreen extends ConsumerStatefulWidget {
  @override
  _AnimalsScreenState createState() => _AnimalsScreenState();
}

class _AnimalsScreenState extends ConsumerState<AnimalsScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(animalsProvider.notifier).getRandomAnimals(10);
  }

  @override
  Widget build(BuildContext context) {
    List<Animal> animals = ref.watch(animalsProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Favorite animals"),
      ),
      body: Column(
        children: [
          const Text("Zoo animals"),
          animals.isNotEmpty
              ? SizedBox(
                  height: 200.0,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (final animal in animals)
                        InkWell(
                          onTap: () => ref
                              .read(animalsProvider.notifier)
                              .markAsFavorite(animal.id!),
                          child: Container(
                              padding: const EdgeInsets.all(10.0),
                              width: 200.0, //TODO: use MediaQuery
                              child: Card(
                                elevation: 10.0,
                                child: Column(
                                  children: [
                                    Text(animal.name ?? "Unknown"),
                                    Text(animal.latinName ?? ""),
                                    Icon(
                                      Icons.favorite,
                                      color: animal.favorite
                                          ? Colors.red
                                          : Colors.grey,
                                    )
                                  ],
                                ),
                              )),
                        ),
                    ],
                  ),
                )
              : Container(),
          const Text("My favorite animals"),
        ],
      ),
    );
  }
}
