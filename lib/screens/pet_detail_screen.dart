import 'package:flutter/material.dart';
import '../models/pet.dart';
import '../models/daily_care_record.dart';

class PetDetailScreen extends StatefulWidget {
  final Pet pet;

  PetDetailScreen({required this.pet});

  @override
  _PetDetailScreenState createState() => _PetDetailScreenState();
}

class _PetDetailScreenState extends State<PetDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.pet.name} Details'),
      ),
      body: ListView.builder(
        itemCount: widget.pet.careRecords.length,
        itemBuilder: (context, index) {
          final record = widget.pet.careRecords[index];
          return ListTile(
            title: Text(record.date.toLocal().toString().split(' ')[0]),
            subtitle: Text(
                'Fed: ${record.fed}, Exercised: ${record.exercised}, Health: ${record.healthStatus}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newRecord = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddCareRecordScreen()),
          );
          if (newRecord != null) {
            setState(() {
              widget.pet.careRecords.add(newRecord);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddCareRecordScreen extends StatefulWidget {
  @override
  _AddCareRecordScreenState createState() => _AddCareRecordScreenState();
}

class _AddCareRecordScreenState extends State<AddCareRecordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _fed = false;
  bool _exercised = false;
  String _healthStatus = 'Normal';
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Daily Care Record'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CheckboxListTile(
                title: Text('Fed'),
                value: _fed,
                onChanged: (value) {
                  setState(() {
                    _fed = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Exercised'),
                value: _exercised,
                onChanged: (value) {
                  setState(() {
                    _exercised = value!;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: _healthStatus,
                items: ['Normal', 'Sick', 'Injured'].map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _healthStatus = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Health Status'),
              ),
              SizedBox(height: 16.0),
              Text('Date: ${_selectedDate.toLocal()}'.split(' ')[0]),
              ElevatedButton(
                onPressed: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != _selectedDate)
                    setState(() {
                      _selectedDate = picked;
                    });
                },
                child: Text('Select date'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newRecord = DailyCareRecord(
                      date: _selectedDate,
                      fed: _fed,
                      exercised: _exercised,
                      healthStatus: _healthStatus,
                    );
                    Navigator.pop(context, newRecord);
                  }
                },
                child: Text('Add Record'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
