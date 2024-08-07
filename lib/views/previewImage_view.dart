// ignore_for_file: file_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:violet_wound/models/pacientes.dart';
import 'package:violet_wound/views/wound_view.dart';
class CameraScreen extends StatefulWidget {
  final File file;
  final Pacientes paciente;
  final String namefile;
  const 
  CameraScreen(
      {Key? key,
      required this.namefile,
      required this.file,
      required this.paciente})
      : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    // FeridasController controller = FeridasController();
    // ControllerCamera controllerCamera = ControllerCamera();
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.file(
                    widget.file,
                    fit: BoxFit.cover,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.black.withOpacity(0.5),
                          child: IconButton(
                              onPressed: () async {                             
                                  Navigator.pop(context);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => WoundView(ferida: widget.paciente.feridas!.last, paciente: widget.paciente, idUser: '',),));                                  
                              },
                              icon: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 30,
                              )),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.black.withOpacity(0.5),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context); 
                              Navigator.pop(context);                              
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}