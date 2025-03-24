
import 'package:bullet_date_selector/bullet_date_selector.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BulletListExampleApp());
}

class BulletListExampleApp extends StatelessWidget {
  const BulletListExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bullet List Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal), useMaterial3: true),
      home: const BulletListDemoPage(),
    );
  }
}

class BulletListDemoPage extends StatelessWidget {
  const BulletListDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Bullet List Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BulletDateSelector(
          onDateSelected: (date) {
            debugPrint('User selected date: $date');
          },
        ),
      ),
    );
  }
}
