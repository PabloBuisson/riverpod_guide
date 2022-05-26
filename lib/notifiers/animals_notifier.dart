import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodguide/services/api_zoo_animals.dart';

import '../models/animal.dart';

/// 0) add a notifier targeting the main object
class AnimalsNotifier extends StateNotifier<List<Animal>> {
  /// By default, the state of the list is an empty list
  /// That state is the first "image" of our list, the start of history
  /// When the state changes (i.e our list changes),
  /// all of our consumer widgets will be prevented
  /// and will display the animals of the new list
  AnimalsNotifier() : super([]);

  Future<void> getRandomAnimals(int size) async {
    ApiZooAnimals.getRandomAnimals(size).then((List<Animal> animals) {
      if (state.isEmpty) {
        state = animals;
      } else {
        // if some animals are already loaded with add the new ones to the list
        List<int> animalsIds = getStateAnimalsIds();
        for (final animal in animals) {
          if (animal.id != null && !animalsIds.contains(animal.id)) {
            state = [...state, animal];
          }
        }
      }
    }, onError: (error) {
      return Future.error(error);
    });
  }

  List<int> getStateAnimalsIds() {
    List<int> animalsIds = [];
    for (final animal in state) {
      if (animal.id != null) {
        animalsIds.add(animal.id!);
      }
    }
    return animalsIds;
  }

  markAsFavorite(int animalId) {
    state = [
      for (final animal in state)
        // we're marking only the matching animal as favorite
        if (animal.id == animalId)
          // Once more, since our state is immutable, we need to make a copy
          // of the animal. We're using our `copyWith` method implemented before
          // to help with that.
          animal.copyWith(favorite: !animal.favorite)
        else
          // other animals are not modified
          animal,
    ];
  }
}
