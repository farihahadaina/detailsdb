/*
  Developers: Nadirah (2027832), Fariha Hadaina (2114478)
*/

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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Row (
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text("Enter Your Details",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold
        ),),
      ],),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
        child: Column(
          children:[
          const SizedBox(height: 20,),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: nameController,
            decoration: const InputDecoration(
              hintText: "e.g. Ali Ahmad",
              hintStyle: TextStyle(
                fontSize: 15,
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
              hintText: "M or F",
              hintStyle: TextStyle(
                fontSize: 15,
              ),
              border: OutlineInputBorder(),
              labelText: "Enter Gender",
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
              hintText: "e.g. 20",
              hintStyle: TextStyle(
                fontSize: 15,
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
              hintText: "dd/mm/yyyy",
              hintStyle: TextStyle(
                fontSize: 15,
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
              hintText: "e.g. Teacher, Engineer, etc",
              hintStyle: TextStyle(
                fontSize: 15,
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
         child: SizedBox(
            width: double.infinity,
            height: 55,
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
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold
            ),
                 ),
                 ),
         )
        )
]),),
      ),

    );
  }
}