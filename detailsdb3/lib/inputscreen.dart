//import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'user.dart';
import 'routes.dart';

class MyInputScreen extends StatefulWidget {
  const MyInputScreen({Key? key}) : super(key: key);

  @override
  State<MyInputScreen> createState() => _MyInputScreenState();
}

class _MyInputScreenState extends State<MyInputScreen> {
  final _formKey = GlobalKey<FormState>();

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
        Text("Enter Your Details",
        style: TextStyle(
          color: Colors.black,
          fontSize: 30,
          fontWeight: FontWeight.bold
        ),),
      ],),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Form(
          key: _formKey,
        child: Column(
          children:[
          const SizedBox(height: 20,),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
            // ignore: body_might_complete_normally_nullable
            validator: (value) {
             if (value!.isEmpty) {
             return 'Please enter your name';
            }
            return null; // Valid input
            },),
          const SizedBox(height: 20,),
          TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
            validator: (value) {
             if (value!.isEmpty) {
             return 'Please enter your gender';
            }
            return null; // Valid input
            },          ),
          const SizedBox(height: 20,),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
            validator: (value) {
             if (value!.isEmpty) {
             return 'Please enter your age';
            }
            return null; // Valid input
            },          ),
          const SizedBox(height: 20, width: 20,),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
            validator: (value) {
             if (value!.isEmpty) {
             return 'Please enter your Date of Birth (DOB)';
            }
            return null; // Valid input
            },          ),
          const SizedBox(height: 20,),
          TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: occupationController,
            decoration: const InputDecoration(
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
              border: OutlineInputBorder(),
              labelText: "Enter Occupation",
          ),
            validator: (value) {
             if (value!.isEmpty) {
             return 'Please enter your occupation';
            }
            return null; // Valid input
            },          ),
        const SizedBox(height: 30,),
        Center(
         child: ElevatedButton(
          onPressed: (){
          if(_formKey.currentState!.validate()){
            Map<String, String> users = {
              'name' : nameController.text,
              'gender' : genderController.text,
              'age' : ageController.text,
              'dob' : dobController.text,
              'occupation' : occupationController.text,
            };
            
            DatabaseReference newRef = dbRef.push();
            newRef.set(users);

            Navigator.pushNamed(
              context,
              Routes.secondScreen,
              arguments: User(
                userKey: newRef.key!,
                name: nameController.text,
                gender: genderController.text,
                age: ageController.text,
                dateOfBirth: dobController.text,
                occupation: occupationController.text,
              ),
            );
          }},
          child: const Text("Add", style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold
),
        ),
        )
        )
]),),
      ),

    );
  }
}