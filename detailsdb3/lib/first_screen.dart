// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
// import 'package:flutter/material.dart';
// import 'user.dart';
// import 'routes.dart';
// import 'package:date_time_picker/date_time_picker.dart';

// class FirstScreen extends StatefulWidget {
//   const FirstScreen({Key? key}) : super(key: key);

//   @override
//   State<FirstScreen> createState() => _FirstScreenState();
// }

// class _FirstScreenState extends State<FirstScreen> {
//   //TextEditingController firstNameController = TextEditingController();
//   //TextEditingController lastNameController = TextEditingController();

//   String _firstName = '';
//   String _lastName = '';
//   String _gender = 'Gender';
//   String _dateOfBirth = '';
//   String _address = '';

//   void _setFirstName(String firstName) {
//     setState(() {
//       _firstName = firstName;
//     });
//   }

//   void _setLastName(String lastName) {
//     setState(() {
//       _lastName = lastName;
//     });
//   }

//   void _setGender(String gender) {
//     setState(() {
//       _gender = gender;
//     });
//   }

//   void _setDOB(String dob) {
//     _dateOfBirth = dob;
//   }

//   void _setAddress(String address) {
//     _address = address;
//   }

//   //final DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();
//   final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

//   Future<void> _saveUserDetails() async {
//    try {
//      await _databaseReference.child('user').push().set({
//        "firstName": _firstName,
//        "lastName": _lastName,
//        "gender": _gender,
//        "dateOfBirth": _dateOfBirth,
//        "address": _address
//      });
//    } catch (e) {
//      //print("Failed to save user details: $e");
//    }
//  }


//   @override
//   Widget build(BuildContext context) {
//     // DatabaseReference _testRef =
//     //     FirebaseDatabase.instance.ref().child('firstName');

//     // _testRef.onValue.listen(
//     //   (event) {
//     //     setState(() {
//     //       _firstName = event.snapshot.value.toString();          
//     //     });
//     // });


//     // DatabaseReference testRef = FirebaseDatabase.instance.ref().child('firstName');

//     // testRef.onValue.listen((event) {
//     //   setState(() {
//     //     _firstName = event.snapshot.value.toString();
//     //   });
//     // });


//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Personal Details'),
//         ),
//         body: Center(
//           child: Container(
//             padding: const EdgeInsets.all(8),
//             child: Column(
//               children: [              
//                 TextFormField(
//                   //controller: firstNameController,
//                   autofocus: true,
//                   decoration: const InputDecoration(hintText: 'First Name'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Invalid First Name';
//                     }
//                     return null;
//                   },
//                   onChanged: (text) {
//                     _setFirstName(text);
//                   },
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 TextFormField(
//                   // controller: lastNameController,
//                   decoration: const InputDecoration(hintText: 'Last Name'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Invalid Last Name';
//                     }
//                     return null;
//                   },
//                   onChanged: (text) {
//                     _setLastName(text);
//                   },
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 DropdownButton<String>(
//                   isExpanded: true,
//                   value: _gender, //selected
//                   icon: const Icon(Icons.arrow_circle_down),
//                   iconSize: 24,
//                   elevation: 16,
//                   underline: Container(
//                     height: 1.5,
//                     color: Colors.grey,
//                   ),
//                   items: <String>['Gender', 'Male', 'Female']
//                       .map<DropdownMenuItem<String>>((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value.toString()),
//                     );
//                   }).toList(),
//                   onChanged: (String? newValue) {
//                     _setGender(newValue.toString());
//                   },
//                 ),
//                 DateTimePicker(
//                     // using date_time_picker package from pub dev
//                     initialValue:
//                         '', // initialValue or controller.text can be null, empty or a DateTime string otherwise it will throw an error.
//                     type: DateTimePickerType.date,
//                     dateLabelText: 'Date of Birth',
//                     firstDate: DateTime(1995),
//                     lastDate: DateTime.now().add(const Duration(
//                         days: 365)), // This will add one year from current date
//                     validator: (value) {
//                       return null;
//                     },
//                     onChanged: (value) {
//                       if (value.isNotEmpty) {
//                         _setDOB(value);
//                       }
//                     }),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 TextFormField(
//                   maxLines: 8, //or null
//                   decoration: const InputDecoration.collapsed(
//                       hintText: "Current Address"),
//                   onChanged: (value) {
//                     _setAddress(value);
//                   },
//                 ),
//                 Container(
//                     margin: const EdgeInsets.all(20),
//                     width: double.infinity,
//                     height: 55,
//                     child: ElevatedButton(
//                       child: const Text('Next'),
//                       // onPressed: () {
//                       //   Navigator.pushNamed(context, Routes.secondScreen,
//                       //       arguments: User(
//                       //           firstName:
//                       //               _firstName, //firstNameController.text.toString(),
//                       //           lastName:
//                       //               _lastName, //lastNameController.text.toString()));
//                       //           gender: _gender,
//                       //           dateOfBirth: _dateOfBirth,
//                       //           address: _address));
//                       // },


//                       // onPressed: () async {
//                       //   await _saveUserDetails();
//                       //   Navigator.pushNamed(context, Routes.secondScreen,
//                       //       arguments: User(
//                       //           firstName: _firstName,
//                       //           lastName: _lastName,
//                       //           gender: _gender,
//                       //           dateOfBirth: _dateOfBirth,
//                       //           address: _address));
//                       // },       
                      
//                       onPressed: () async {
//                         await _saveUserDetails();
//                         // ignore: use_build_context_synchronously
//                         Navigator.pushNamed(context, Routes.secondScreen,
//                             arguments: User(
//                                 firstName: _firstName,
//                                 lastName: _lastName,
//                                 gender: _gender,
//                                 dateOfBirth: _dateOfBirth,
//                                 address: _address));
//                       },  
                                     

//                     )),
//               ],
//             ),
//           ),
//         ));
//   }
// }
