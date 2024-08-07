// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use, use_build_context_synchronously

// ignore_for_file: must_be_immutable, file_names
import 'dart:async';
import 'dart:ui';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:violet_wound/Utils/app_validator.dart';
import 'package:violet_wound/Widgets/myTextForm.dart';
import 'package:violet_wound/Widgets/shimmerHomePage.dart';
import 'package:violet_wound/controllers/paciente_controller.dart';
import 'package:violet_wound/models/user.dart';
import 'package:violet_wound/service/api_service.dart';
import 'package:violet_wound/views/settings_view.dart';
import '../Widgets/containerPaciente.dart';

class HomePage extends StatefulWidget {
  String? idUser;
  String? nomeUser;
  HomePage({
    Key? key,
     this.idUser,
  }) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {  
  var keypaciente = GlobalKey<FormState>();
  late PacienteController controller;
  ApiService service = ApiService();

  @override
  void initState() {
    super.initState(); 
  }

  @override
  Widget build(BuildContext context) {    
    controller = Provider.of<PacienteController>(context);  
    bool onclick = true;      
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(        
          automaticallyImplyLeading: false,
          toolbarHeight: 50.0,
          backgroundColor: const Color.fromARGB(255, 39, 0, 79),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [                        
              const Text('Violet Wound'),
              PopupMenuButton(
                itemBuilder: (context) =>  [                
                  const PopupMenuItem(
                    value: 'settings',
                    child: Text('Configurações'),                  
                  ),
                ],
                tooltip: '',
                onSelected: (value) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Settings(nomeUser: widget.nomeUser,)));
                },
              ),
            ],
          ),    
        ),
        body: RefreshIndicator(
          color: const Color.fromARGB(255, 39, 0, 79),
          onRefresh: () async {
            setState(() {});
          },
          child: futureBuilderGetPacientes(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
          onPressed: ()  {          
            showDialog(
              context: context,
              builder: (context) => BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: AlertDialog(
                  backgroundColor: const Color(0xFFEEEFF5),
                  title: const Text(
                    'Adicionar Paciente',
                    textAlign: TextAlign.center,
                  ),
                  content: SizedBox(
                    height: 260.0,
                    width: 180.0,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Form(
                            key: keypaciente,
                            child: Column(
                              children: [
                                myTextForm(
                                    picon: const Icon(Icons.person),
                                    titulo: 'Nome:',
                                    hinttext: 'Entre com o nome',
                                    validar: (value) => AppValidator.validateName(value),
                                    controller: controller.crtName
                                ),
                                myTextForm(
                                    titulo: 'CPF:',
                                    hinttext: 'XXX.XXX.XXX-XX',
                                    validar: (value) => AppValidator.validateCPF(value!),
                                    keyboardType: TextInputType.number,
                                    controller: controller.crtlCpf,
                                    inputFormatters:[
                                      FilteringTextInputFormatter.digitsOnly,
                                      CpfInputFormatter()
                                    ],
                                ),
                                myTextForm(
                                    titulo: 'Data de nascimento:',
                                    hinttext: 'DD/MM/AAAA',                                    
                                    validar: (value) => AppValidator.validateDateNasc(value!),
                                    controller: controller.crtlBirthDate,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      DataInputFormatter()
                                    ],
                                    picon: IconButton(
                                        onPressed: () async {
                                          customDatePicker(context);
                                        },
                                        icon: const Icon(Icons.calendar_month),
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          ElevatedButton(
                            onPressed: () async{
                              if(keypaciente.currentState!.validate() && onclick) {
                                  try {
                                    setState(() {
                                        onclick = false;
                                    });
                                    var retorno = await controller.adicionarPaciente(keypaciente, context, widget.idUser!);                                    
                                    if (retorno) {                                                                           
                                      setState(() {});
                                    }
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()))); 
                                  }
                              }                                                             
                            },
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 39, 0, 79),
                            ),
                            child: const Text("Atendimento"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        backgroundColor: const Color.fromARGB(255, 39, 0, 79),
        tooltip: 'Adicionar Paciente',
        child: const Icon(Icons.add),
        ),
      ),
    );
  }  
  Future<void> customDatePicker(BuildContext context) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale.fromSubtags(countryCode: "BR", languageCode: "pt"),
    );
    if (date != null) {
      setState(() {
        DateFormat('dd/MM/yyyy').format(date);
        controller.crtlBirthDate.text = '${date.day}/${date.month}/${date.year}';
      });
    }
  }

 futureBuilderGetPacientes(){
    widget.idUser ??= ModalRoute.of(context)!.settings.arguments as String?;
    return FutureBuilder<User?>(
      future: service.getUser(widget.idUser!),
      builder: (context, snapshot){
        final status = snapshot.connectionState;
        if (status == ConnectionState.waiting) {
          return const ShimmerHomePage();
        }else if (snapshot.hasError){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(child: Text("Ocorreu um erro")),
              SizedBox(
                child: TextButton(onPressed: () {
                  setState(() {});
                }, child: const Text("Tente Novamente")),
              )
            ],
          );
        }else if (status == ConnectionState.done) {
          if (snapshot.hasData) {
            var pacientes = snapshot.data!.pacientes;
            widget.nomeUser = snapshot.data!.name;
            if (pacientes?.isNotEmpty ?? false) {
              return GridView.builder(            
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0),
                itemCount: pacientes!.length,
                itemBuilder: (context, index) => ContainerPaciente(pacientes[index], idUser: widget.idUser!, index: index,),
              );
            }
            return const Center(child: Text("Não há pacientes"));
          }
        }
        return Column(
          children: [
            const Center(child: Text("Erro em pegar os dados")),
            SizedBox(
              child: TextButton(onPressed: () {
                setState(() {});
              }, child: const Text("Tente Novamente")),
            )
          ],
        );                    
      },
    );
  }    

}