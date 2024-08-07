// ignore_for_file: nullable_type_in_catch_clause

import 'package:flutter/material.dart';
import 'package:violet_wound/models/pacientes.dart';
import 'package:violet_wound/service/api_service.dart';

import '../models/user.dart';
import '../views/editPaciente_view.dart';

class PacienteController extends ChangeNotifier{
  final _crtName = TextEditingController();
  final _crtCpf = TextEditingController();
  final _crtlBirthDate = TextEditingController();
  final _crtPeso = TextEditingController();
  final _crtAltura = TextEditingController();
  final _crtHgt = TextEditingController();
  final _crtPressao = TextEditingController();
  final _crtCardio = TextEditingController();
  DateTime? birthDate;

  TextEditingController get crtName => _crtName;
  TextEditingController get crtlCpf => _crtCpf;
  TextEditingController get crtlBirthDate => _crtlBirthDate;
  TextEditingController get crtPeso => _crtPeso;
  TextEditingController get crtAltura => _crtAltura;
  TextEditingController get crtHgt => _crtHgt;
  TextEditingController get crtPressao => _crtPressao;
  TextEditingController get crtCardio => _crtCardio;

  ApiService service = ApiService();

  Future<bool> adicionarPaciente(GlobalKey<FormState> keypaciente, BuildContext context, String id) async {
    var paciente =  Pacientes(nome: crtName.text, cpf: crtlCpf.text, data: crtlBirthDate.text, peso: double.tryParse(crtPeso.text)?? 0, altura: double.tryParse(crtAltura.text)?? 0, hgt: int.tryParse(crtHgt.text)?? 0, pressao: crtPressao.text, cardio: int.tryParse(crtCardio.text)?? 0);
    try {
      await service.addPaciente(paciente, id).then((e) async {
          paciente.iD = e['id'];
          crtName.clear();
          crtlCpf.clear();
          crtlBirthDate.clear();
          notifyListeners();  
          await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditPaciente(idUser: id, paciente: paciente)));                                     
          
      });
      return true;
    } on dynamic catch (e) {
      throw e.message;
    }
  }

  Future<bool> editPaciente(BuildContext context, Pacientes paciente, String idUser) async{
      try{        
        await service.editPaciente(paciente, idUser);
        return true;
      } on dynamic catch (e) {
        throw e.message;
      }
  }

  Future removePaciente(String idUser, int index) async{
    try{
      var e = await service.removePaciente(idUser, index);
      notifyListeners();
      return e["message"];
    }on dynamic catch (e){
      throw e.message;
    }
  }

  Future<User?> getPacientes(String idUser) async{
    try {
      return await service.getUser(idUser);
    } catch (e) {
      rethrow;
    }
  }
}