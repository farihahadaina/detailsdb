import 'package:detailsdb/updatescreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:detailsdb/inputscreen.dart';
import 'package:flutter/material.dart';

String capitalize(String text) {
  if (text.isEmpty) {
    return text;
  }
  return text[0].toUpperCase() + text.substring(1);
}

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

final databaseReference = FirebaseDatabase.instance.ref().child("Users");

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Information Details",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),

      //display all infos
      body: Column(
        children: [
          Expanded(
              child: FirebaseAnimatedList(
                  query: databaseReference,
                  itemBuilder: (context, snapshot, index, animation) {
                    if (snapshot.child("name").value == null ||
                        snapshot.child("name").value.toString().isEmpty ||
                        snapshot.child("age").value == null ||
                        snapshot.child("age").value.toString().isEmpty) {
                      // If it is, return an empty Container
                      return Container();
                    }
                    return GestureDetector(
                        child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                          title: Text(
                            capitalize(snapshot.child("name").value.toString()),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          subtitle: Text(
                            '\n'
                            'Gender : ${capitalize(snapshot.child("gender").value.toString())} \n'
                            'Age : ${capitalize(snapshot.child("age").value.toString())} \n'
                            'Date of Birth : ${capitalize(snapshot.child("dob").value.toString())} \n'
                            'Occupation : ${capitalize(snapshot.child("occupation").value.toString())}',
                          ),
                          trailing: const Icon(Icons.edit),
                          onTap: () {
                            Map<String, dynamic> userData = {
                              'name': snapshot.child("name").value.toString(),
                              'gender':
                                  snapshot.child("gender").value.toString(),
                              'age': snapshot.child("age").value.toString(),
                              'dob': snapshot.child("dob").value.toString(),
                              'occupation':
                                  snapshot.child("occupation").value.toString(),
                            };

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateScreen(
                                  userKey: snapshot.key!,
                                  data: userData,
                                ),
                              ),
                            );
                          }),
                    ));
                  })),
        ],
      ),

      //(+) button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MyInputScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
