import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:detailsdb/inputscreen.dart';
import 'package:firebase_database/firebase_database.dart';


class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}
final databaseReference = FirebaseDatabase.instance.ref("Users");
class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const MyInputScreen()));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(title: const Row (
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text("Information Details",
        style: TextStyle(
          color: Colors.black,
          fontSize: 30,
          fontWeight: FontWeight.bold
        ),),
      ],),),
 body: Column(
        children: [
          Expanded(
              child: FirebaseAnimatedList(
                  query: databaseReference,
                  itemBuilder: (context, snapshot, index, animation) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(
                          snapshot.child("name").value.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                            ),
                      ),
                    );
                  })),
        ],
      ),
    );
  }
}