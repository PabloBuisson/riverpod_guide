import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

// ConsumerStatefulWidget  is like a StatefulWidget
class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  NotificationsScreenState createState() => NotificationsScreenState();
}

class NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  @override
  void dispose() {
    // "ref" can be used in all life-cycles of a StatefulWidget
    // will reset the counterNotifications to 0 when the user leaves the page
    ref.invalidate(counterNotifications);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          textScaleFactor: 1.6,
        ),
      ),
    );
  }
}
