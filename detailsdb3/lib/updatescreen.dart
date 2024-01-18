/*
  Developers: Maryam Umairah (2110256), Fariha Hadaina (2114478)
*/

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'user.dart';
import 'routes.dart';

class UpdateScreen extends StatefulWidget {
  final String userKey;
  final Map<String, dynamic> data;
  const UpdateScreen({Key? key, required this.data, required this.userKey})
      : super(key: key);

  @override
  State<UpdateScreen> createState() => _MyUpdateScreenState();
}

class _MyUpdateScreenState extends State<UpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController genderController;
  late TextEditingController ageController;
  late TextEditingController dobController;
  late TextEditingController occupationController;
  late TextEditingController userKeyController;

  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child("Users");

    nameController = TextEditingController(text: widget.data['name']);
    genderController = TextEditingController(text: widget.data['gender']);
    ageController = TextEditingController(text: widget.data['age']);
    dobController = TextEditingController(text: widget.data['dob']);
    occupationController = TextEditingController(text: widget.data['occupation']);
    userKeyController = TextEditingController(text: widget.userKey);
  }

  @override
  void dispose() {
    nameController.dispose();
    genderController.dispose();
    ageController.dispose();
    dobController.dispose();
    occupationController.dispose();
    userKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "User Details",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
          child: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter Name",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: genderController,
              decoration: const InputDecoration(
                hintText: "M or F",
                hintStyle: TextStyle(
                  fontSize: 15,
                ),
                border: OutlineInputBorder(),
                labelText: "Enter Gender",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your gender';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: ageController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter Age",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your age';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 15,
              width: 20,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: dobController,
              decoration: const InputDecoration(
                hintText: "dd/mm/yyyy",
                hintStyle: TextStyle(
                  fontSize: 15,
                ),
                border: OutlineInputBorder(),
                labelText: "Enter DOB",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your date of birth';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: occupationController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter Occupation",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your occupation';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
                child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState != null &&
                      _formKey.currentState!.validate()) {
                    // If the form is valid, update the user.
                    Map<String, dynamic> users = {
                      'name': nameController.text,
                      'gender': genderController.text,
                      'age': ageController.text,
                      'dob': dobController.text,
                      'occupation': occupationController.text,
                    };
                    dbRef.child(widget.userKey).update(users).then((value) {
                      Navigator.pushNamed(
                        context,
                        Routes.secondScreen,
                        arguments: User(
                          userKey: userKeyController.text,
                          name: nameController.text,
                          gender: genderController.text,
                          age: ageController.text,
                          dateOfBirth: dobController.text,
                          occupation: occupationController.text,
                        ),
                      );
                    });
                    // Display a Snackbar.
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')));
                  } else {
                    // If the form is invalid, display a Snackbar.
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Please fill in all fields')));
                  }
                },
                child: const Text(
                  "Update",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )),
            Expanded(child: Container()),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // delete dialog box
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Delete Confirmation'),
                        content: const Text(
                            'Are you sure you want to delete this user?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              dbRef
                                  .child(widget.userKey)
                                  .remove(); // delete from firebase database
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('User deleted'),
                                  duration: Duration(seconds: 3),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              Navigator.pushNamed(context,
                                  Routes.homeScreen); // redirect to home screen
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).scaffoldBackgroundColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: const BorderSide(color: Colors.red, width: 1),
                    ),
                  ),
                  elevation:
                      MaterialStateProperty.all(0), //to remove the shadow
                ),
                child: const Text('Delete User',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          ]),
        ),
      )),
    );
  }
}
