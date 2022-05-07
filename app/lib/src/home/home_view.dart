import 'dart:math';

import 'package:flutter/material.dart';

import '../combat/combat_view.dart';
import '../settings/settings_view.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  static const routeName = '/';

  final TextEditingController textController = TextEditingController(text: "Anonymous#${Random().nextInt(10000)}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Titan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(controller: textController),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () =>
                Navigator.restorablePushNamed(context, CombatView.routeName, arguments: textController.value.text),
            child: const Text('Join'),
          ),
        ],
      ),
    );
  }
}
