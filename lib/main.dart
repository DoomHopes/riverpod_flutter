import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'clock.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod',
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

final valueProvider = Provider<int>((ref) {
  return 36;
});

final counterStateProvider = StateProvider<int>((ref) {
  return 0;
});

final clockProvider = StateNotifierProvider<Clock, DateTime>((ref) {
  return Clock();
});

class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // this line is used to watch the provider's *state*
    // to get an instance of the clock itself,
    // call `ref.watch(clockProvider.notifier)`
    final currentTime = ref.watch(clockProvider);
    // format the time as `hh:mm:ss`
    final timeFormatted = DateFormat.Hms().format(currentTime);
    return Scaffold(
      body: Center(
        child: Text(
          timeFormatted,
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }
}

/*class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterStateProvider);
    ref.listen(
      counterStateProvider,
      (StateController<int> counterState) {
        // note: this callback executes when the provider value changes,
        // not when the build method is called
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Value is ${counterState.state}')),
        );
      },
    );
    return Scaffold(
      body: Center(
        child: Text(
          'Value: ${counter.state}',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(counterStateProvider).state++,
        child: const Icon(Icons.add),
      ),
    );
  }
}*/

/*class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(valueProvider);
    return Scaffold(
      body: Center(
        child: Text(
          'Value: $value',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }
}*/

/*
class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  void initState() {
    super.initState();
    final value = ref.read(valueProvider);
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    final value = ref.watch(valueProvider);
    return Scaffold(
      body: Center(
        child: Text(
          'Value: $value',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }
}*/
