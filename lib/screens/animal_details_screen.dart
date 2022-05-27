import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/animal.dart';
import '../providers.dart';

class AnimalDetailsScreen extends ConsumerWidget {
  const AnimalDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Animal animal = ref.watch(animalsProvider.notifier).selectedAnimal;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Animal details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                animal.name ?? "Unknown",
                textScaleFactor: 1.6,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              // responsive text
              Text(
                animal.latinName ?? "",
                textScaleFactor: 1.1,
                textAlign: TextAlign.center,
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 250.0,
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
              RowDetail(
                labelDetail: "Type",
                detail: animal.animalType,
              ),
              RowDetail(
                labelDetail: "Active time",
                detail: animal.activeTime,
              ),
              RowDetail(
                labelDetail: "Active time",
                detail: animal.activeTime,
              ),
              RowDetail(
                labelDetail: "Length minimum",
                detail: animal.lengthMin,
              ),
              RowDetail(
                labelDetail: "Length maximum",
                detail: animal.lengthMax,
              ),
              RowDetail(
                labelDetail: "Weight minimum",
                detail: animal.weightMin,
              ),
              RowDetail(
                labelDetail: "Weight maximum",
                detail: animal.weightMax,
              ),
              RowDetail(
                labelDetail: "Lifespan",
                detail: animal.lifespan,
              ),
              RowDetail(
                labelDetail: "Habitat",
                detail: animal.habitat,
              ),
              RowDetail(
                labelDetail: "Diet",
                detail: animal.diet,
              ),
              RowDetail(
                labelDetail: "Geographic range",
                detail: animal.geoRange,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RowDetail extends StatelessWidget {
  const RowDetail({
    Key? key,
    required this.labelDetail,
    required this.detail,
  }) : super(key: key);

  final String labelDetail;
  final String? detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check,
            size: 20.0,
            color: Colors.purple,
          ),
          const SizedBox(
            width: 10.0,
          ),
          Text(
            "$labelDetail : ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Flexible(child: Text(detail ?? "Unknown"))
        ],
      ),
    );
  }
}
