/*
  Developers: Nadirah (2027832), Fariha Hadaina (2114478)
*/

import 'package:firebase_database/firebase_database.dart';
import 'package:detailsdb/homescreen.dart';
import 'package:flutter/material.dart';
import 'user.dart';

class SecondScreen extends StatefulWidget {
  final String userKey;
  const SecondScreen({Key? key, required this.userKey}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child("Users");
  }

  @override
  Widget build(BuildContext context) {
    User user = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      appBar: AppBar(        
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Details Confirmation",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.all(20),         
              child: Text(
                'Name  : ${user.name}',
                style: const TextStyle(fontSize: 15)),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.all(20),
              child: Text('Gender  : ${user.gender}',
              style: const TextStyle(fontSize: 15)),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.all(20),
              child: Text('Age  : ${user.age}',
              style: const TextStyle(fontSize: 15)),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.all(20),
              child: Text('Date of Birth  : ${user.dateOfBirth}',
              style: const TextStyle(fontSize: 15)),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.all(20),
              child: Text('Occupation  : ${user.occupation}',
              style: const TextStyle(fontSize: 15)),
            ),
            Container(
                margin: const EdgeInsets.all(20),
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    // Save the user data to the database.
                    Map<String, dynamic> users = {
                      'name': user.name,
                      'gender': user.gender,
                      'age': user.age,
                      'dob': user.dateOfBirth,
                      'occupation': user.occupation,
                    };
                    dbRef.child(user.userKey).update(users).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Information details updated'),
                          duration: const Duration(seconds: 3),
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      );
                    });

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyHomeScreen()));
                  },
                  child: const Text(
                    "Confirm",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}