//import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'main.dart';
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
      appBar: AppBar(title: const Row (
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text("Update Information Details",
        style: TextStyle(
          color: Colors.black,
          fontSize: 30,
          fontWeight: FontWeight.bold
        ),),
      ],),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Column(children:[
          const SizedBox(height: 20,),
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
              border: OutlineInputBorder(),
              labelText: "Enter Name",
            ),
          ),
          const SizedBox(height: 20,),
          TextFormField(
            controller: genderController,
            decoration: const InputDecoration(
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
              border: OutlineInputBorder(),
              labelText: "Gender (M/F)",
            ),
          ),
          const SizedBox(height: 20,),
          TextFormField(
            controller: ageController,
            decoration: const InputDecoration(
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
              border: OutlineInputBorder(),
              labelText: "Enter Age",
            ),
          ),
          const SizedBox(height: 20, width: 20,),
          TextFormField(
            controller: dobController,
            decoration: const InputDecoration(
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
              border: OutlineInputBorder(),
              labelText: "Enter DOB",
            ),
          ),
          const SizedBox(height: 20,),
          TextFormField(
            controller: occupationController,
            decoration: const InputDecoration(
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
              border: OutlineInputBorder(),
              labelText: "Enter Occupation",
          ),),
        const SizedBox(height: 30,),
        Center(
         child: ElevatedButton(
          onPressed: (){
            Map<String, String> users = {
              'name' : nameController.text,
              'gender' : genderController.text,
              'age' : ageController.text,
              'dob' : dobController.text,
              'occupation' : occupationController.text,
            };

            dbRef.child(widget.userKey).update(users).then((value) => {
            Navigator.pushNamed(context, Routes.secondScreen,
                            arguments: User(
                                name: nameController.text,
                                gender: genderController.text,
                                age: ageController.text,
                                dateOfBirth: dobController.text,
                                occupation: occupationController.text)) 
            });
            // dbRef.push().set(users);
        }, 
          child: const Text("Update", style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold
),
        ),
        )
        )
]),
      ),

    );
  }
}