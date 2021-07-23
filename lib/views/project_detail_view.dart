import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final counterProvider = StateNotifierProvider<Counter, int>((_) => Counter());

class Counter extends StateNotifier<int> {
  Counter() : super(0);
  void increment() => state++;
}

class ProjectDetailView extends HookWidget {
  const ProjectDetailView({Key? key, required this.title, required this.color})
      : super(key: key);

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final count = useProvider(counterProvider);

    void _onPressedFloatingActionButton(BuildContext context) {
      context.read(counterProvider.notifier).increment();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${title}Detail'),
      ),
      body: Center(
        child: Text(
          count.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 36,
            color: color,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onPressedFloatingActionButton(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
