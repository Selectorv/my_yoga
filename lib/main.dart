import 'package:flutter/material.dart';
import 'package:my_yoga/intro_screen.dart';


void main() {
  runApp(const MyApp());
}
class  RouteNames{
  static const String intro = "/";
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true, 
        primarySwatch: Colors.blue,
       ),
       routes: {
        RouteNames.intro: (context) => const IntroScreen(),
       },
     );
    }
   }
   
   
    