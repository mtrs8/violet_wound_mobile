// ignore_for_file: file_names, camel_case_types, nullable_type_in_catch_clause, dead_code, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:violet_wound/Utils/app_validator.dart';
import 'package:violet_wound/Widgets/myTextForm.dart';
import 'package:violet_wound/controllers/paciente_controller.dart';
import 'package:violet_wound/models/pacientes.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:violet_wound/service/api_service.dart';

class EditPaciente extends StatefulWidget {
  final Pacientes paciente;
  final String idUser;
  const EditPaciente({Key? key, required this.paciente, required this.idUser}) : super(key: key);
  @override
  State<EditPaciente> createState() => _EditPacienteState();
}

class _EditPacienteState extends State<EditPaciente> {
  PacienteController controller = PacienteController();
  var keypaciente = GlobalKey<FormState>();  
  ApiService service = ApiService();
  bool _showloading = true;
  var maskPressao = MaskTextInputFormatter(mask: '###/###', filter: { "#": RegExp(r'[0-9]') }, type: MaskAutoCompletionType.lazy);
  var maskCardio = MaskTextInputFormatter(mask: '###', filter: { "#": RegExp(r'[0-9]') }, type: MaskAutoCompletionType.lazy);
  var maskAltura = MaskTextInputFormatter(mask: '#.###', filter: { "#": RegExp(r'[0-9]') }, type: MaskAutoCompletionType.lazy);
  var maskPeso = MaskTextInputFormatter(mask: '###.###', filter: { "#": RegExp(r'[0-9]') }, type: MaskAutoCompletionType.lazy);
  var maskHgt = MaskTextInputFormatter(mask: '####', filter: { "#": RegExp(r'[0-9]') }, type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    double? width = MediaQuery.of(context).size.width * 0.9;
    
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [ 
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                    ),
                ),
              ),
              SizedBox(
                width: width,
                child: Column(
                  children: [
                    const Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Dados do Paciente',
                              style: TextStyle(color: Colors.black, fontSize: 20.0,fontFamily: 'Sen'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Form(
                      key: keypaciente,
                      child: Column(
                        children: [
                            myTextForm(
                              initialValue: widget.paciente.nome,
                              titulo: "Nome",
                              validar: (value){
                                if(AppValidator.validateName(value!) == null){
                                  widget.paciente.nome = value;
                                }
                                return AppValidator.validateName(value);
                              },
                            ),
                          myTextForm(
                            titulo: "CPF:",
                            initialValue: widget.paciente.cpf,
                            inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  CpfInputFormatter()
                                ],
                            validar: (value){
                              if(AppValidator.validateCPF(value!) == null){
                                widget.paciente.cpf = value;
                              }
                              return AppValidator.validateCPF(value);                             
                              
                            },
                          ),
                          myTextForm(
                            titulo: "Data De Nascimento:",
                            initialValue: widget.paciente.data,
                            inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  DataInputFormatter()
                                ],
                            validar: (value){
                              if(AppValidator.validateDateNasc(value!) == null){
                                widget.paciente.data = value;
                              }
                              return AppValidator.validateDateNasc(value);
                            },
                          ),
                          Row(
                            children: [
                              myTextForm(
                                width: width * 0.28,
                                titulo: 'Peso',
                                initialValue: widget.paciente.peso.toString(),
                                keyboardType: TextInputType.number,
                                validar: (value) {
                                    widget.paciente.peso = double.tryParse(value!)?? 0;
                                    return null;
                                },
                              ),
                              myTextForm(
                                width: width * 0.28,
                                titulo: 'Altura',
                                initialValue: widget.paciente.altura.toString(),
                                inputFormatters: [maskAltura],
                                keyboardType: TextInputType.number,
                                validar: (value) {
                                    widget.paciente.altura = double.tryParse(value!)?? 0;
                                    return null;
                                },
                              ),
                              myTextForm(
                                width: width * 0.28,
                                titulo: 'HGT',
                                initialValue: widget.paciente.hgt.toString(),
                                keyboardType: TextInputType.number,
                                inputFormatters: [maskHgt],
                                validar: (value) {
                                    widget.paciente.hgt = int.tryParse(value!)?? 0;
                                    return null;                                                           
                                },
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              myTextForm(
                                width: width * 0.45,
                                titulo: 'Pressão Arterial',
                                initialValue: widget.paciente.pressao.toString(),
                                keyboardType: TextInputType.number,
                                inputFormatters: [maskPressao],
                                validar: (value) {
                                    widget.paciente.pressao = value!;
                                    return null;
                                },
                              ),
                              myTextForm(
                                width: width * 0.45,
                                titulo: 'Frequência cardíaca',
                                initialValue: widget.paciente.cardio.toString(),
                                keyboardType: TextInputType.number,
                                inputFormatters: [maskCardio],
                                validar: (value) {                        
                                    widget.paciente.cardio = int.tryParse(value!)?? 0;
                                    return null;
                                }
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),                      
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: _showloading ? TextButton(
                  onPressed: () async {
                    setState(() { _showloading = !_showloading;});
                    var valido = keypaciente.currentState!.validate();
                    if (valido) {
                      try {
                        await controller.editPaciente(context, widget.paciente, widget.idUser);                        
                      } on dynamic catch (e){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                      } finally{
                        Navigator.pop(context);
                      }
                    }
                    setState(() { _showloading = !_showloading;});            
                  },
                  child: const Text('SALVAR')
                ) : const CircularProgressIndicator(color: Color.fromARGB(255, 39, 0, 79)),
              ),            
            ],          
          ),
        ),
      ),
    );
  }
}
