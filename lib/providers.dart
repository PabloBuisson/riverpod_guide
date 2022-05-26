import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/animal.dart';
import 'notifiers/animals_notifier.dart';

abstract class WebsocketClient {
  Stream<int> getCounterStream();
}

class FakeWebsocketClient implements WebsocketClient {
  @override
  Stream<int> getCounterStream() async* {
    int i = 0;
    while (true) {
      await Future.delayed(const Duration(minutes: 5));
      yield i++;
    }
  }
}

// declaration of providers
// readOnly values
final cityProvider = Provider((ref) => 'London');
final countryProvider = Provider((ref) => 'England');
// simple mutable values (String, bool, int)
final counterProvider = StateProvider((ref) => 0);
// 💡 0 is the initial value of our provider
// final counterProvider = StateProvider.autoDispose((ref) => 0);
// 💡 autoDispose will reset the value when no longer used
// the provider will automatically destroy its state when it is no longer being listened to

final websocketClientProvider = Provider<WebsocketClient>(
  (ref) {
    return FakeWebsocketClient();
  },
);

// StreamProvider
final counterNotifications = StreamProvider<int>((ref) {
  final wsClient = ref.watch(websocketClientProvider);
  return wsClient.getCounterStream();
});

// StateNotifierProvider
final animalsProvider =
    StateNotifierProvider<AnimalsNotifier, List<Animal>>((ref) {
  return AnimalsNotifier();
});
