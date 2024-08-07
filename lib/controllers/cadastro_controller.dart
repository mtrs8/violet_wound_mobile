
import 'package:flutter/material.dart';
import 'package:violet_wound/models/user.dart';
import 'package:violet_wound/service/api_service.dart';

class CadastroController{

  final _crtName = TextEditingController();
  final _crtlEmail = TextEditingController();
  final _crtlPassword = TextEditingController();
  final _crtlConfirmPassword = TextEditingController();
  final _crtlBirthDate = TextEditingController();
  DateTime? birthDate;

  TextEditingController get crtName => _crtName;
  TextEditingController get crtlEmail => _crtlEmail;
  TextEditingController get crtlConfirmPassword => _crtlConfirmPassword;
  TextEditingController get crtlPassword => _crtlPassword;
  TextEditingController get crtlBirthDate => _crtlBirthDate;

  Future<bool> validar(GlobalKey<FormState> formKey, BuildContext context) async {
    if (formKey.currentState!.validate()) {   
      try {
          User user = User(email: crtlEmail.text, senha: crtlPassword.text, name: crtName.text);
          await ApiService().criarConta(user);
          return true;
      } catch (e){
        rethrow;
      }
    }
    return false;
  }
}