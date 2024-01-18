import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'user.dart';
import 'routes.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({Key? key, this.userKey = ''}) : super(key: key);

  final String userKey;

  @override
  State<UpdateScreen> createState() => _MyUpdateScreenState();
}

class _MyUpdateScreenState extends State<UpdateScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();

  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child("Users");
    getUserDetails();
  }

  void getUserDetails() async {
    DataSnapshot snapshot = await dbRef.child(widget.userKey).get();
    Map user = snapshot.value as Map;
    nameController.text = user['name'];
    genderController.text = user['gender'];
    ageController.text = user['age'];
    dobController.text = user['dob'];
    occupationController.text = user['occupation'];
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
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Enter Name",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: genderController,
            decoration: const InputDecoration(
              hintText: "M or F",
              hintStyle: TextStyle(
                fontSize: 15,
              ),
              border: OutlineInputBorder(),
              labelText: "Enter Gender",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: ageController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Enter Age",
            ),
          ),
          const SizedBox(
            height: 15,
            width: 20,
          ),
          TextFormField(
            controller: dobController,
            decoration: const InputDecoration(
              hintText: "dd/mm/yyyy",
              hintStyle: TextStyle(
                fontSize: 15,
              ),
              border: OutlineInputBorder(),
              labelText: "Enter DOB",
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: occupationController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Enter Occupation",
            ),
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

              onPressed: (){
                
                Map<String, String> users = {
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
                      userKey: widget.userKey,
                      name: nameController.text,
                      gender: genderController.text,
                      age: ageController.text,
                      dateOfBirth: dobController.text,
                      occupation: occupationController.text,
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('User details updated'),
                      duration: const Duration(seconds: 3),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  );
                });
              },
              child: const Text(
                "Update",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                  );                      
                } 
                );
              
              }, 
              child: const Text("Update", style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
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
                elevation: MaterialStateProperty.all(0), //to remove the shadow
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
    );
  }
}
