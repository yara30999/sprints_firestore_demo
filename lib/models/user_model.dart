import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? name;
  final String? favouriteHoppy;
  final int? age;

  User({
    this.name,
    this.favouriteHoppy,
    this.age,
  });

  factory User.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return User(
        name: data?['name'],
        favouriteHoppy: data?['favourite_hoppy'],
        age: data?['age']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (favouriteHoppy != null) "favourite_hoppy": favouriteHoppy,
      if (age != null) "age": age,
    };
  }
}
