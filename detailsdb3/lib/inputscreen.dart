//import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'user.dart';
import 'routes.dart';
import 'updatescreen.dart';

class MyInputScreen extends StatefulWidget {
  const MyInputScreen({Key? key}) : super(key: key);

  @override
  State<MyInputScreen> createState() => _MyInputScreenState();
}

class _MyInputScreenState extends State<MyInputScreen> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Row (
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text("Enter Information Details",
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
            Navigator.pushNamed(context, Routes.secondScreen,
                            arguments: User(
                                name: nameController.text,
                                gender: genderController.text,
                                age: ageController.text,
                                dateOfBirth: dobController.text,
                                occupation: occupationController.text));

            dbRef.push().set(users);
        }, 
          child: const Text("Add", style: TextStyle(
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