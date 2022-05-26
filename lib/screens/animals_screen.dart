import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
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
                            AnimalCard(ref: ref, animal: animal),
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

class AnimalCard extends StatelessWidget {
  const AnimalCard({
    Key? key,
    required this.ref,
    required this.animal,
  }) : super(key: key);

  final WidgetRef ref;
  final Animal animal;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          ref.read(animalsProvider.notifier).markAsFavorite(animal.id!),
      child: Container(
          padding: const EdgeInsets.all(10.0),
          width: MediaQuery.of(context).size.width * 0.7,
          child: Card(
            elevation: 10.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // responsive text
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      animal.name ?? "Unknown",
                      textScaleFactor: 1.6,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  // responsive text
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      animal.latinName ?? "",
                      textScaleFactor: 1.1,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 100.0,
                    child: animal.imageLink != null
                        ? CachedNetworkImage(
                            placeholder: (context, url) => Container(
                              width: double.infinity,
                              color: Colors.grey[200],
                            ),
                            imageUrl: animal.imageLink!,
                          )
                        : Container(
                            width: double.infinity,
                            color: Colors.grey[200],
                          ),
                  ),

                  const SizedBox(
                    height: 20.0,
                  ),
                  Icon(
                    Icons.favorite,
                    color: animal.favorite ? Colors.red : Colors.grey,
                    size: 30.0,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
