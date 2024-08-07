// ignore_for_file: use_build_context_synchronously, nullable_type_in_catch_clause
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:violet_wound/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:violet_wound/service/prefs_service.dart';
import 'package:violet_wound/views/cadastro_view.dart';

class LoginController {
  final _crtEmail = TextEditingController();
  final _crtSenha = TextEditingController();

  TextEditingController get crtEmail => _crtEmail;
  TextEditingController get crtSenha => _crtSenha;

  static final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> validar(GlobalKey<FormState> formKey,
      GlobalKey<FormState> emailKey, BuildContext context) async {
    if (formKey.currentState!.validate() && emailKey.currentState!.validate()) {
      try {
        var e = await ApiService().login(crtEmail.text, crtSenha.text);
        var idUser = e['id'];
        SharedPreference.save(idUser);
        return idUser;
      } catch (e) {
        rethrow;
      }
    }
    return '';
  }

  static Future logOut() async {
    bool isSignedIn = await googleSignIn.isSignedIn();
    //await googleSignIn.disconnect();
    if (isSignedIn) {
      await googleSignIn.disconnect();
    }
    SharedPreference.remove();
  }

  static Future<void> signInWithGoogle(BuildContext context) async {
    try {
      var user = await googleSignIn.signIn();
      if (user == null) {
        throw Exception("Login Cancelado");
      }
      String userName = user.displayName!;
      String userEmail = user.email;
      var value = await ApiService().loginWithGoogle(userEmail, userName);
      if (value == null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Cadastro(nome: userName, email: userEmail);
        }));
      } else {
        SharedPreference.save(value);
        Navigator.of(context).pushReplacementNamed('/home', arguments: value);
      }
    } on dynamic catch (e) {
      throw e.message;
    }
  }

  Future resetPassword() async {
    await ApiService().resetSenha(crtEmail.text);
  }
}
