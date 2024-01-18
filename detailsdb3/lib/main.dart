import 'package:detailsdb/updatescreen.dart';
import 'package:flutter/material.dart';
import 'routes.dart';
// import 'first_screen.dart';
import 'inputscreen.dart';
import 'second_screen.dart';
import 'homescreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Form Widget',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        // home: const MyHomePage(title: 'Flutter Form Widget'),
        initialRoute: Routes.homeScreen,
        routes: {
          Routes.homeScreen: (context) => const MyHomeScreen(),
          Routes.firstScreen: (context) => const MyInputScreen(),
          Routes.secondScreen: (context) => const SecondScreen(),
          Routes.updateScreen: (context) => const UpdateScreen(
                data: {},
                userKey: '',
              ),
        });
  }
}
