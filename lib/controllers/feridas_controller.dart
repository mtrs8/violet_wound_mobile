// ignore_for_file: nullable_type_in_catch_clause

import 'package:flutter/material.dart';
import 'package:violet_wound/models/feridas.dart';
import 'package:violet_wound/service/api_service.dart';

class FeridasController extends ChangeNotifier{
  final _crtLocal = TextEditingController();
  final _crtTempo = TextEditingController();
  final _crtlTipo = TextEditingController();

  TextEditingController get crtLocal => _crtLocal;
  TextEditingController get crtTempo => _crtTempo;
  TextEditingController get crtlTipo => _crtlTipo;
  ApiService service = ApiService();

  Wound getWound(){
    return Wound(local: crtLocal.text, tempo: crtTempo.text, tipologia: crtlTipo.text);
  }

  removeFerida(String key, String idUser, int index) async {
    try{
      var e = await service.removeferida(key, idUser, index);
      notifyListeners();
      return e['message'];
    }on dynamic catch (e){
      throw e.message;
    }
  }
  void clearAll(){
    crtLocal.clear();
    crtTempo.clear();
    crtlTipo.clear();
  }
}