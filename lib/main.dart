// ignore_for_file: must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import 'package:violet_wound/controllers/camera_controller.dart';
import 'package:violet_wound/controllers/feridas_controller.dart';
import 'package:violet_wound/controllers/paciente_controller.dart';
import 'package:violet_wound/views/homePage_view.dart';
import 'package:violet_wound/views/login_view.dart';
import 'package:violet_wound/views/splash_view.dart';

List<CameraDescription> cameras = [];
Future<void> main() async{
  //  try {
  //   cameras = await availableCameras();
  // } on CameraException catch (e) {
  //   print('Error in fetching the cameras: $e');
  // }
  
  runApp(const Myapp());
}
class Myapp extends StatefulWidget {  
  const Myapp({Key? key}) : super(key: key);  

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {

  String? idUser;

  @override
  void initState() {
    super.initState();    
  }


  @override
  Widget build(BuildContext context) {        
    return  MultiProvider(
      providers:[
        ChangeNotifierProvider(
          create: (context) => PacienteController(),
        ),
        ChangeNotifierProvider(
          create: (context) => FeridasController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ControllerCamera(),
        ),
      ],
      child: MaterialApp(      
        debugShowCheckedModeBanner: false,
        home: const Splash(),
        localizationsDelegates: const [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        routes: {
          '/login': (context) => const Login(),
          '/home' : (context) => HomePage(),
        },
      ),
    );
  }
}