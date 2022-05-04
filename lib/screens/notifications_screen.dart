import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main.dart';

// ConsumerWidget is like a StatelessWidget
// but with a WidgetRef parameter added in the build method.
class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Stream Provider ↓
    final AsyncValue<int> notificationsLength = ref.watch(counterNotifications);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My notifications"),
      ),
      body: Center(
        child: Text(
          notificationsLength.when(
              data: (int value) => "You have $value notifications",
              error: (Object error, _) =>
                  "A problem occurred, please try again later",
              loading: () => "Loading..."),
        ),
      ),
    );
  }
}
