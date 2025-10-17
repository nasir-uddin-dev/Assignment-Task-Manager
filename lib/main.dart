import 'package:assignment_task_manager/screens/splash_screen.dart';
import 'package:flutter/material.dart';


//starting point for run
void main(){
  runApp(const MyApp());
}


//This class is actually material app design. Here I can design themeData and
//change theme whenever I want. I can do UI looking nicely

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
