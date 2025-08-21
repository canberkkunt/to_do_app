import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Ayarlar Sayfası', style: TextStyle(color: Colors.white)),
      ),
      backgroundColor: Colors.grey.shade900,
    );
  }
}
