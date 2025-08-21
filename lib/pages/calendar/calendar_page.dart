import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Takvim Sayfası', style: TextStyle(color: Colors.white)),
      ),
      backgroundColor: Colors.grey.shade900,
    );
  }
}
