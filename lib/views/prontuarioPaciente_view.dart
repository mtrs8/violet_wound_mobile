// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names, use_build_context_synchronously, unnecessary_null_comparison, unused_local_, prefer_typing_uninitialized_variables, deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:violet_wound/Widgets/CustomSnackBar.dart';
import 'package:violet_wound/Widgets/myTextForm.dart';
import 'package:violet_wound/Widgets/shimmerProntuario.dart';
import 'package:violet_wound/controllers/camera_controller.dart';
import 'package:violet_wound/controllers/feridas_controller.dart';
import 'package:violet_wound/models/pacientes.dart';
import 'package:violet_wound/service/api_service.dart';
import 'package:violet_wound/views/editPaciente_view.dart';
import 'package:violet_wound/views/wound_view.dart';

import '../Widgets/noInternet.dart';
import '../Widgets/shimmerWound.dart';

// ignore: must_be_immutable
class ProntuarioPaciente extends StatefulWidget {
  String? idUser;
  Pacientes paciente;
  ProntuarioPaciente({
    Key? key,
    this.idUser,
    required this.paciente,
  }) : super(key: key);
  @override
  State<ProntuarioPaciente> createState() => _ProntuarioPacienteState();
}

class _ProntuarioPacienteState extends State<ProntuarioPaciente> {
  var keypaciente = GlobalKey<FormState>();
  late FeridasController controller;
  late ControllerCamera controllerCamera;
  bool update = false;
  

  @override
  Widget build(BuildContext context) {
    controller = Provider.of<FeridasController>(context);
    controllerCamera = ControllerCamera();
    
    Future<void> fetchData() async {
      await Future.delayed(const Duration(seconds: 1));
    }

    Future<Pacientes?> updateData() async {
      return ApiService().getPaciente(widget.paciente.iD, widget.idUser);
    }

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/home', (Route<dynamic> route) => false,
            arguments: widget.idUser);
        return true;
      },
      child: Scaffold(
        body: FutureBuilder(
          future: update ? updateData() : fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const MyShimmer();
            } else if (snapshot.hasError) {
              SchedulerBinding.instance.addPostFrameCallback((_){
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Erro ao atualizar o prontuário")));
              });
              return prontuario();
            } else {
              if (snapshot.data != null) {
                widget.paciente = snapshot.data! as Pacientes;                
              }
              return prontuario();
            }
          },
        ),
      ),
    );
  }

  Widget prontuario() {
    double? width = MediaQuery.of(context).size.width;
    double? height = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      color: const Color.fromARGB(255, 39, 0, 79),
      onRefresh: () async {
        setState(() {
          update = true;
        });
      },
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color.fromARGB(255, 39, 0, 79),
            automaticallyImplyLeading: false,
            shadowColor: const Color.fromARGB(255, 39, 0, 79),
            leading: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/home', (Route<dynamic> route) => false,
                        arguments: widget.idUser);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xFFc5e5f3),
                  ),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Stack(
                children: [
                  Container(
                    height: height * 0.4,
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
                      const SizedBox(height: 10),
                      Container(
                        width: width,
                        height: 320,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(left: 25, right: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 20,
                                spreadRadius: 1,
                                offset: const Offset(-10, 0),
                                color: Colors.black.withOpacity(0.2)),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Nome: ${widget.paciente.nome}",
                                    style: const TextStyle(
                                      fontSize: 20
                                      ,fontFamily: 'Sen'
                                    )),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromARGB(255, 234, 243, 247),
                                    ),
                                    child: IconButton(
                                        onPressed: () async {
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      EditPaciente(
                                                          paciente:
                                                              widget.paciente,
                                                          idUser: widget
                                                              .idUser!))));
                                          setState(() {
                                            update = true;
                                          });
                                        },
                                        icon: const Icon(Icons.edit)),
                                  ),
                                )
                              ],
                            ),
                            Text("CPF: ${widget.paciente.cpf}",
                                style: const TextStyle(
                                  fontSize: 20,fontFamily: 'Sen'
                                )),
                            const SizedBox(height: 10),
                            Text("Data de Nascimento: ${widget.paciente.data}",
                                style: const TextStyle(
                                  fontSize: 20,fontFamily: 'Sen'
                                )),
                            const SizedBox(height: 10),
                            Text("Peso: ${widget.paciente.peso} kg",
                                style: const TextStyle(
                                  fontSize: 20,fontFamily: 'Sen'
                                )),
                            const SizedBox(height: 10),
                            Text("Altura: ${widget.paciente.altura} m",
                                style: const TextStyle(
                                  fontSize: 20,fontFamily: 'Sen'
                                )),
                            const SizedBox(height: 10),
                            Text("HGT: ${widget.paciente.hgt} mg/dL",
                                style: const TextStyle(
                                  fontSize: 20,fontFamily: 'Sen'
                                )),
                            const SizedBox(height: 10),
                            Text("Pressão Arterial: ${widget.paciente.pressao} mmhg",
                                style: const TextStyle(
                                  fontSize: 20,fontFamily: 'Sen'
                                )),
                            const SizedBox(height: 10),
                            Text(
                                "Frequência Cardíaca: ${widget.paciente.cardio} bpm",
                                style: const TextStyle(
                                  fontSize: 20,fontFamily: 'Sen'
                                )),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 40, top: 20),
                            child: Text(
                              "FERIDAS",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20,fontFamily: 'Sen'),
                            ),
                          ),
                          Container(
                            height: widget.paciente.feridas!.isEmpty
                                ? height * 0.2
                                : widget.paciente.feridas!.length == 1 ?
                                (widget.paciente.feridas!.length + 1) * height * 0.1:
                                 widget.paciente.feridas!.length < 3
                                    ? (widget.paciente.feridas!.length ) * height * 0.1
                                    : height * 0.3,
                            margin: const EdgeInsets.only(
                                left: 25, right: 25, bottom: 25, top: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 20,
                                    spreadRadius: 1,
                                    offset: const Offset(-10, 0),
                                    color: Colors.black.withOpacity(0.2)),
                              ],
                            ),
                            child: widget.paciente.feridas!.isEmpty
                                ? const Center(
                                    child: Text(
                                    "SEM FERIDAS",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sen'),
                                  ))
                                : ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    itemCount: widget.paciente.feridas!.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      WoundView(
                                                          ferida: widget
                                                              .paciente
                                                              .feridas![index],
                                                          paciente:
                                                              widget.paciente,
                                                          idUser:
                                                              widget.idUser!)));
                                        },
                                        child: ListTile(
                                          leading: const Icon(
                                            Icons.local_hospital,
                                            color: Colors.red,
                                          ),
                                          title: Text(widget
                                              .paciente.feridas![index].local),
                                          subtitle: Text(widget.paciente
                                              .feridas![index].tipologia),
                                          trailing: IconButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          'Apagar ferida'),
                                                      content: const Text(
                                                          'Deseja apagar a ferida?'),
                                                      actions: [
                                                        TextButton(
                                                            onPressed:
                                                                () async {
                                                              var message;
                                                              try {
                                                                message = await context
                                                                    .read<
                                                                        FeridasController>()
                                                                    .removeFerida(
                                                                        widget
                                                                            .paciente
                                                                            .iD!,
                                                                        widget
                                                                            .idUser!,
                                                                        index);
                                                                setState(() {
                                                                  update = true;
                                                                });
                                                              } catch (e) {
                                                                message = e;
                                                              } finally {
                                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                        behavior: SnackBarBehavior.floating,
                                                                        elevation: 0,
                                                                        backgroundColor: Colors.transparent,
                                                                        content: CustomSnackBar(title: message)));
                                                                Navigator.pop(
                                                                    context);
                                                              }
                                                            },
                                                            child: const Text(
                                                                'Sim')),
                                                        TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            child: const Text(
                                                                'Não')),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              icon: const Icon(Icons.delete)),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 39, 0, 79)),
                            ),
                            onPressed: () async{
                                    bool enableButton = await NoInternet.checkInternetConnection();
                                    if(enableButton){
                                      showDialog(
                                      context: context,
                                      builder: (context) => BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 3, sigmaY: 3),
                                        child: SimpleDialog(
                                          title: const Center(
                                              child:
                                                  Text("DADOS DA FERIDA")),
                                          titlePadding:
                                              const EdgeInsets.only(
                                                  top: 30),
                                          shape:
                                              const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              8))),
                                          children: [
                                            Form(
                                                key: keypaciente,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          8.0),
                                                  child: Column(
                                                    children: [
                                                      myTextForm(
                                                          titulo: "Local",
                                                          validar: (value) {
                                                            if (value ==
                                                                    null ||
                                                                value
                                                                    .isEmpty) {
                                                              return 'Informe o local';
                                                            }
                                                            return null;
                                                          },
                                                          controller:
                                                              controller
                                                                  .crtLocal),
                                                      myTextForm(
                                                          titulo: "Tempo",
                                                          validar: (value) {
                                                            if (value ==
                                                                    null ||
                                                                value
                                                                    .isEmpty) {
                                                              return 'Informe o Tempo';
                                                            }
                                                            return null;
                                                          },
                                                          controller:
                                                              controller
                                                                  .crtTempo),
                                                      myTextForm(
                                                          titulo:
                                                              "Tipologia",
                                                          validar: (value) {
                                                            if (value ==
                                                                    null ||
                                                                value
                                                                    .isEmpty) {
                                                              return 'Informe a Tipologia';
                                                            }
                                                            return null;
                                                          },
                                                          controller:
                                                              controller.crtlTipo),
                                                      const SizedBox(
                                                          height: 20),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          if (keypaciente
                                                              .currentState!
                                                              .validate()) {
                                                            Navigator.pop(
                                                                context);
                                                            showDialog(
                                                              context:
                                                                  context,
                                                              builder:
                                                                  (context) =>
                                                                      SimpleDialog(
                                                                title:
                                                                    const Center(
                                                                  child:
                                                                      Text(
                                                                    "De onde deseja tirar a foto?",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20,fontFamily: 'Sen'),
                                                                  ),
                                                                ),
                                                                titlePadding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top:
                                                                            30),
                                                                shape:
                                                                    const RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius.circular(
                                                                        8),
                                                                  ),
                                                                ),
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            30,
                                                                        right:
                                                                            30),
                                                                    child:
                                                                        TextButton(
                                                                      onPressed:
                                                                          () async {
                                                                        var wound =
                                                                            controller.getWound();
                                                                        var imagem = await controllerCamera.getCamera();                                                                                                                                                
                                                                        if (imagem != null) {
                                                                          await Navigator.pushReplacement(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                  builder: (context) => ShimmerWound(
                                                                                        ferida: wound,
                                                                                        iD: widget.paciente.iD!,
                                                                                        userImage: imagem,
                                                                                        paciente: widget.paciente,
                                                                                        idUser: widget.idUser!,
                                                                                      ))).then((value) => setState(() {
                                                                                update = true;
                                                                              }));
                                                                          controller.clearAll();
                                                                        }
                                                                      },
                                                                      child:
                                                                          const Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Icon(Icons.camera_alt_outlined, color: Colors.black),
                                                                          Text('Câmera', style: TextStyle(color: Colors.black,fontFamily: 'Sen')),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            30,
                                                                        right:
                                                                            30),
                                                                    child: TextButton(
                                                                        onPressed: () async {
                                                                          var wound = controller.getWound();
                                                                          var imagem = await controllerCamera.getGallery();                                                                                                                                                   
                                                                          if (imagem != null) {
                                                                            await Navigator.pushReplacement(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                    builder: (context) => ShimmerWound(
                                                                                          ferida: wound,
                                                                                          iD: widget.paciente.iD!,
                                                                                          userImage: imagem,
                                                                                          paciente: widget.paciente,
                                                                                          idUser: widget.idUser!,
                                                                                        ))).then((value) => setState(() {
                                                                                  update = true;
                                                                                }));
                                                                            controller.clearAll();
                                                                          }
                                                                        },
                                                                        child: const Row(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          children: [
                                                                            Icon(
                                                                              Icons.image_outlined,
                                                                              color: Colors.black,
                                                                            ),
                                                                            Text('Galeria', style: TextStyle(color: Colors.black,fontFamily: 'Sen')),
                                                                          ],
                                                                        )),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          }
                                                        },
                                                        style:
                                                            ElevatedButton
                                                                .styleFrom(
                                                          primary:
                                                              const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  39,
                                                                  0,
                                                                  79),
                                                        ),
                                                        child: const Text(
                                                            "Tirar a Foto"),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    );
                                    }else{
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Sem internet")));
                          
                                    }
                                  },
                            child: const Text("Adicionar ferida"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              childCount: 1,
            ),
          )
        ],
      ),
    );
  }
}
