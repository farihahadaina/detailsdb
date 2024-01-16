import 'package:flutter/material.dart';
import 'package:detailsdb/inputscreen.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

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
      );
  }
}