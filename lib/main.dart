import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers.dart';
import 'screens/advices_screen.dart';
import 'screens/animals_screen.dart';
import 'screens/notifications_screen.dart';

void main() {
  // 🔔 For providers to work,
  // you need to add ProviderScope at the root of your Flutter applications
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

// Using ConsumerWidget, this allows the widget tree to listen to changes on provider,
// so that the UI automatically updates when needed
class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);
  // no longer needed ↓
  //  final _counter = 0;
  //  void _incrementCounter() {
  //     _counter++;
  //  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Returns the value exposed by a provider
    // and rebuild the widget when that value change
    // State Provider ↓
    final int counter = ref.watch(counterProvider);
    // Stream Provider ↓
    final AsyncValue<int> notificationsLength = ref.watch(counterNotifications);

    // 💡 to perform ACTIONS => navigation, showing alerts, snackbars, ect.
    // Listen to a provider and call listener whenever its value changes.
    // This is useful for showing modals or other imperative logic.
    ref.listen<int>(counterProvider, (previous, next) {
      if (next >= 5) {
        // when our counterProvider is greater than 5
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Warning'),
                content: const Text(
                    'Counter dangerously high. Consider resetting it.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  )
                ],
              );
            });
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("HomePage"),
        actions: [
          IconButton(
              onPressed: () {
                // invalidates the state of the provider, causing it to refresh
                // 💡 Calling invalidate will cause the provider to be disposed immediately
                ref.invalidate(counterProvider);
              },
              icon: const Icon(Icons.refresh)),
          Badge(
            position: BadgePosition.topEnd(top: 10, end: 10),
            showBadge: // with async value, we use the "when" method
                notificationsLength.when(
                    data: (int value) => value > 0,
                    error: (Object error, _) => false,
                    loading: () => false),
            badgeContent: Text(
              // with async value, we use the "when" method
              notificationsLength
                  .when(
                      data: (int value) => value,
                      error: (Object error, _) => "0",
                      loading: () => "0")
                  .toString(),
              style: const TextStyle(color: Colors.white),
            ),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const NotificationsScreen()),
                  ));
                },
                icon: const Icon(Icons.notifications)),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              // 💡 WATCH => will rebuild the widget when the value changes
              // ref.watch(counterProvider).toString(),
              counter.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => AdvicesScreen()),
                  ));
                },
                child: const Text("Grab an advice")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => AnimalsScreen()),
                  ));
                },
                child: const Text("Learn about animals")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 💡 READ => only check the value, without rebuilding the widget if changes
          ref.read(counterProvider.notifier).state++;
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
