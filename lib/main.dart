import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// declaration of providers
// readOnly values
final cityProvider = Provider((ref) => 'London');
final countryProvider = Provider((ref) => 'England');
// simple mutable values (String, bool, int)
final counterProvider = StateProvider((ref) => 0);
// 💡 0 is the initial value of our provider
// final counterProvider = StateProvider.autoDispose((ref) => 0);
// 💡 autoDispose will reset the value when no longer used

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
              icon: const Icon(Icons.refresh))
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
              ref.watch(counterProvider).toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
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
