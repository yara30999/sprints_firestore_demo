import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sprints_firestore_demo/models/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _hobbyController = TextEditingController();

  Future<void> _saveData() async {
    try {
      final name = _nameController.text.trim();
      final age = int.tryParse(_ageController.text.trim());
      final hobby = _hobbyController.text.trim();

      if (name.isEmpty || age == null || hobby.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please fill out all fields!")),
        );
        return;
      }

      // Save data to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .add(User(name: name, age: age, favouriteHoppy: hobby).toFirestore());
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Data saved successfully!")),
        );
      }

      // Clear the input fields
      _nameController.clear();
      _ageController.clear();
      _hobbyController.clear();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error saving data: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("home screen")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 16.0,
            left: 16.0,
            right: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 20,
            children: [
              SizedBox(height: 50),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: _ageController,
                decoration: InputDecoration(labelText: "Age"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _hobbyController,
                decoration: InputDecoration(labelText: "Favorite Hobby"),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: _saveData,
                child: Text("Save Data"),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("View Data"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
