// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:violet_wound/controllers/camera_controller.dart';
import 'package:violet_wound/models/feridas.dart';
import 'package:violet_wound/models/pacientes.dart';
import 'package:violet_wound/service/api_service.dart';
import 'package:violet_wound/views/wound_view.dart';

// ignore: must_be_immutable
class ShimmerWound extends StatefulWidget {
  String iD;
  String idUser;
  File userImage;
  Wound ferida;
  Pacientes paciente;
  ShimmerWound({
    Key? key,
    required this.iD,
    required this.idUser,
    required this.userImage,
    required this.ferida,
    required this.paciente,
  }) : super(key: key);
  @override
  State<ShimmerWound> createState() => _WoundViewState();
}

class _WoundViewState extends State<ShimmerWound> {
  ControllerCamera controllerCamera = ControllerCamera();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Wound?>(
        future: ApiService().addFerida(widget.ferida, widget.iD, widget.userImage, widget.idUser),
        builder: (context, snapshot) {             
          double? width = MediaQuery.of(context).size.width;
          double? height = MediaQuery.of(context).size.height;       
          var status = snapshot.connectionState;
          if(status == ConnectionState.waiting){            
              return Container(
              color: Colors.white,
              child: Stack(
                children: [
                  Container(
                    height: height * 0.35,
                    width: width,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 39, 0, 79),
                            Color.fromARGB(255, 85, 15, 155),
                          ]),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: height * 0.15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          width: width,
                          height: height * 0.8,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 20,
                                  spreadRadius: 1,
                                  offset: const Offset(-10, 0),
                                  color: Colors.black.withOpacity(0.2)
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(color: Color.fromARGB(255, 39, 0, 79)),
                                SizedBox(height: 10),
                                Text("ANALISANDO A FERIDA", style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sen'),)
                              ]
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          if(status == ConnectionState.done){
              if(snapshot.data != null){
                Wound ferida = snapshot.data!;                          
                return WoundView(ferida: ferida, paciente: widget.paciente, idUser: widget.idUser);
              }
            SchedulerBinding.instance.addPostFrameCallback((_){
              if (snapshot.hasError) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Erro ao fazer a análise")),
                );
              }            
            });
          }
        return  Container(
              color: Colors.white,
              child: Stack(
                children: [
                        Container(
                          height: height * 0.35,
                          width: width,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromARGB(255, 39, 0, 79),
                                  Color.fromARGB(255, 85, 15, 155),
                                ]),
                          ),
                        ),
                        Column(
                  children: [
                    SizedBox(
                      height: height * 0.15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        width: width,
                        height: height * 0.8,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 20,
                                spreadRadius: 1,
                                offset: const Offset(-10, 0),
                                color: Colors.black.withOpacity(0.2)
                            ),
                          ],
                        ),
                        child:  Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding:  EdgeInsets.all(8.0),
                                child:  Icon(Icons.error_outline),
                              ),
                              const Center(child: Text("Erro ao fazer a análise")),
                              SizedBox(
                                child: TextButton(onPressed: () {
                                  setState(() {});
                                }, child: const Text("Tente Novamente")),
                              )
                            ]
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          );        
        },
      )
    );
  }
}