// import 'package:detailsdb/second_screen.dart';
import 'package:detailsdb/updatescreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:detailsdb/inputscreen.dart';
import 'package:flutter/material.dart';
// import 'user.dart';

String capitalize(String text) {
  if (text.isEmpty) {
    return text;
  }
  return text[0].toUpperCase() + text.substring(1);
}

// User fromSnapshot(DataSnapshot snapshot) {
//   return User(
//     name: snapshot.value['name'],
//     gender: snapshot.value['gender'],
//     age: snapshot.value['age'],
//     dateOfBirth: snapshot.value['dateOfBirth'],
//     occupation: snapshot.value['occupation'],
//     userKey: snapshot.key!,
//   );
// }

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

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
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UpdateScreen()),
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             UpdateScreen(userKey: user.userKey)));
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            title: Text(
                              capitalize(
                                  snapshot.child("name").value.toString()),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            // subtitle: Text(snapshot.child("age").value.toString()),
                            subtitle: Text(
                              '\n'
                              'Gender : ${capitalize(snapshot.child("gender").value.toString())} \n'
                              'Age : ${capitalize(snapshot.child("age").value.toString())} \n'
                              'Date of Birth : ${capitalize(snapshot.child("dob").value.toString())} \n'
                              'Occupation : ${capitalize(snapshot.child("occupation").value.toString())}',
                            ),
                            trailing: const Icon(Icons.edit),
                          ),
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
