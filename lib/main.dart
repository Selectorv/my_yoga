import 'package:flutter/material.dart';
import 'package:my_yoga/consts.dart';
import 'package:my_yoga/home_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

 

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
 

      
      void main() => runApp(const MyApp());
      
      class MyApp extends StatefulWidget {
        const MyApp({super.key});
      
        @override
        State<MyApp> createState() => _MyAppState();
      }
      
      class _MyAppState extends State<MyApp> {
        late GoogleMapController mapController;
      
        final LatLng _center = const LatLng(-33.86, 151.20);
      
        void _onMapCreated(GoogleMapController controller) {
          mapController = controller;
        }
      
        @override
        Widget build(BuildContext context) {
          return MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                title: const Text('Maps Sample App'),
                backgroundColor: Colors.green[700],
              ),
              body: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
              ),
            ),
          );
        }
      }
