import 'package:flutter/material.dart';
import 'package:my_yoga/consts.dart';
import 'package:my_yoga/home_page.dart';

 

// ignore: non_constant_identifier_names
void main(Gemini) {
  Gemini.init(
    apikey: GEMINI_API_KEY,
  );
  runApp(const MyApp());
}




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,  
      ),
      home: const HomePage(),
      );
   }
}


//flutter pub add google_generative_ai
 

 
