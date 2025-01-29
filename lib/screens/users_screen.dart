import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sprints_firestore_demo/models/user_model.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("View Data")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error fetching data"));
          }

          final users = snapshot.data?.docs ?? [];

          if (users.isEmpty) {
            return Center(child: Text("No data available"));
          }

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final userDoc =
                  users[index] as DocumentSnapshot<Map<String, dynamic>>;
              final user = User.fromFirestore(userDoc);

              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(user.name!),
                  subtitle:
                      Text("Age: ${user.age} | Hobby: ${user.favouriteHoppy}"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
