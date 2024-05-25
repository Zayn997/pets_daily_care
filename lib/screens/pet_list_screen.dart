import 'package:flutter/material.dart';
import '../models/pet.dart';
import 'add_pet_screen.dart';
import 'pet_detail_screen.dart';

class PetListScreen extends StatefulWidget {
  @override
  _PetListScreenState createState() => _PetListScreenState();
}

class _PetListScreenState extends State<PetListScreen> {
  final List<Pet> pets = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Pets'),
      ),
      body: pets.isEmpty
          ? Center(child: Text('No pets added yet!'))
          : ListView.builder(
              itemCount: pets.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(pets[index].name),
                  subtitle: Text(pets[index].type),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PetDetailScreen(pet: pets[index]),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newPet = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPetScreen()),
          );
          if (newPet != null) {
            setState(() {
              pets.add(newPet);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
