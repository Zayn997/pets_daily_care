import 'package:flutter/material.dart';
import 'screens/pet_list_screen.dart';

void main() {
  runApp(PetsDailyCareApp());
}

class PetsDailyCareApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pets Daily Care',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: PetListScreen(),
    );
  }
}
