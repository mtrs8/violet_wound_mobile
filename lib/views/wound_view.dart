// ignore_for_file: file_names, unnecessary_null_compari, unrelated_type_equality_checks, depend_on_referenced_packages, unused_import

import 'package:flutter/material.dart';
import 'package:violet_wound/Widgets/noInternet.dart';
import 'package:violet_wound/controllers/camera_controller.dart';
import 'package:violet_wound/models/feridas.dart';
import 'package:violet_wound/models/pacientes.dart';
import 'package:http/http.dart' as http;
import '../models/pdf.dart';
import '../service/pdfApi_service.dart';
import 'detailsWound_view.dart';


class WoundView extends StatefulWidget {
  final String idUser;
  final Pacientes paciente;
  final Wound ferida;
  const WoundView({
    Key? key,
    required this.ferida,
    required this.paciente, 
    required this.idUser, 
  }) : super(key: key);
  @override
  State<WoundView> createState() => _WoundViewState();
}

class _WoundViewState extends State<WoundView> {
  ControllerCamera controllerCamera = ControllerCamera();

  @override
  Widget build(BuildContext context) {
    double? width = MediaQuery.of(context).size.width;
    double? height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: Container(
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
                Positioned(
                  top: 50,
                  left: 10,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xFFc5e5f3),
                    ),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [                        
                            const Padding(
                              padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                   Icon(
                                    Icons.local_hospital,
                                    size: 40,
                                    color: Colors.red,
                                  ),
                                  Text("FERIDA", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'Sen'),),
                                ],
                              ),
                            ),                        
                            SizedBox(
                              width: width,
                              height: height * 0.36,
                              child: ClipRRect(
                                borderRadius: BorderRadius.zero,
                                child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(8.0)
                                        ),                                    
                                        child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: RawMaterialButton(                                     
                                            onPressed: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                    builder: (context) => DetailsWound(imageurl: widget.ferida.imageurl!),
                                                  ));
                                            },
                                            child: Image.network(widget.ferida.imageurl!, fit: BoxFit.fitWidth, height: 500, width: 500, loadingBuilder: (context, child,loadingProgress) {
                                              if(loadingProgress == null) return child;
                                              return const CircularProgressIndicator(color: Color.fromARGB(255, 39, 0, 79));
                                            },
                                            errorBuilder:(context, error, stackTrace) => const Text('Erro ao exibir a imagem'),)
                                          ),
                                        )
                                      ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text("Local: ${widget.ferida.local}",
                                style: const TextStyle(
                                  fontSize: 20,fontFamily: 'Sen'
                                )),
                            const SizedBox(height: 10),
                            Text("Tempo: ${widget.ferida.tempo}",
                                style: const TextStyle(
                                  fontSize: 20,fontFamily: 'Sen'
                                )),
                            const SizedBox(height: 10),
                            Text(
                              "Tipologia: ${widget.ferida.tipologia}",
                              style: const TextStyle(
                                fontSize: 20,fontFamily: 'Sen'
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Carga Bactériana: ${widget.ferida.carga}",
                              style: const TextStyle(
                                fontSize: 20,fontFamily: 'Sen'
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Pseudomonas: ${widget.ferida.pseudomonas}",
                              style: const TextStyle(
                                fontSize: 20,fontFamily: 'Sen'
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center(child: ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 39, 0, 79)),), 
                              onPressed: () async{
                                final pdf = await Pdf.generate(widget.paciente, widget.ferida);
                                await PdfApi.saveDocument(name: 'laudo_${widget.paciente.nome}.pdf', bytes: pdf);
                              }, 
                              child: const Text("Gerar PDF", style: TextStyle(fontFamily: 'Sen'),)))
                          ],
                        ),
                      ),
                    ),                  
                  ],
                ),              
              ],
            ),
          ),
        ),
      );
  } 
}