import 'package:detailsdb/routes.dart';
// import 'package:detailsdb/updatescreen.dart';
import 'package:flutter/material.dart';
import 'user.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    User user = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Confirmation'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              alignment: Alignment.centerLeft,
              child: Text('Name  : ${user.name}'),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.all(15),
              child: Text('Gender  : ${user.gender}'),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.all(15),
              child: Text('Age  : ${user.age}'),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.all(15),
              child: Text('Date of Birth  : ${user.dateOfBirth}'),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.all(15),
              child: Text('Occupation  : ${user.occupation}'),
            ),
            Container(
                margin: const EdgeInsets.all(20),
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateScreen(userKey: user.userKey)));
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //             UpdateScreen(userKey: user.userKey)));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const SizedBox(
                          height: 60.0, // Set the height you want
                          child: Text(
                            'User details updated',
                            style: TextStyle(
                                fontSize: 20), // Increase the font size
                          ),
                        ),
                        duration: const Duration(seconds: 4),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    );

                    Navigator.pushNamed(context, Routes.homeScreen);
                  },
                  child: const Text('Confirm'),
                )),
          ],
        ),
      ),
    );
  }
}
