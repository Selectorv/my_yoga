import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  // ignore: use_super_parameters
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     // ignore: prefer_const_constructors
     return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/Natured logo.png"), 
          const SizedBox(
            height: 30,
          ),
          Text(
            "Women and girls Healthcare",
            style:TextStyle(fontSize:25, color: Colors.grey.shade900),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Gender equality",
              style: TextStyle(fontSize: 17, color: Colors.grey.shade500),  
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
            onPressed: () {},
               style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
             child: Text(
              "Getting Started",
             style:TextStyle(fontSize: 20),
             ),
           ))      
        ],
      ),
     );
  }
}