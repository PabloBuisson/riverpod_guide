import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodguide/screens/animal_details_screen.dart';

import '../models/animal.dart';
import '../providers.dart';

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
    return Stack(
      children: [
        Container(
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
                      height: 10.0,
                    ),
                    InkWell(
                      onTap: () => ref
                          .read(animalsProvider.notifier)
                          .markAsFavorite(animal.id!),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        width: double.infinity,
                        child: Icon(
                          Icons.favorite,
                          color: animal.favorite ? Colors.red : Colors.grey,
                          size: 30.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
        animal.id != null
            ? Positioned(
                right: -10.0,
                top: -6.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) =>
                          AnimalDetailsScreen(animalId: animal.id!)),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                  ),
                  child: const FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Icon(Icons.info, size: 20.0)),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
