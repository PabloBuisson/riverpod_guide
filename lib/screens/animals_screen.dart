import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/animal.dart';
import '../providers.dart';
import '../widgets/animal_card.dart';

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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 30.0, bottom: 10.0),
                child: Text(
                  "Zoo animals",
                  textScaleFactor: 2.0,
                ),
              ),
              animals.isNotEmpty
                  ? SizedBox(
                      height: 300.0,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: [
                          for (final animal in animals)
                            if (animal != animals.last)
                              AnimalCard(ref: ref, animal: animal)
                            else
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AnimalCard(ref: ref, animal: animal),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: ElevatedButton(
                                      onPressed: () => ref
                                          .read(animalsProvider.notifier)
                                          .getRandomAnimals(10),
                                      child: const FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: Icon(Icons.arrow_forward_ios,
                                              size: 18)),
                                    ),
                                  )
                                ],
                              ),
                        ],
                      ),
                    )
                  : const CircularProgressIndicator(),
              const Padding(
                padding: EdgeInsets.only(top: 50.0, bottom: 10.0),
                child: Text(
                  "My favorite animals",
                  textScaleFactor: 2.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: animals.isNotEmpty
                    ? SizedBox(
                        height: 300.0,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            for (final animal in animals)
                              if (animal.favorite)
                                AnimalCard(ref: ref, animal: animal),
                          ],
                        ),
                      )
                    : const CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
