import 'package:shared_preferences/shared_preferences.dart';
class SharedPreference {

  static save(String idUser) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('idUser', idUser);

  }

  static getId() async {
    var prefs = await SharedPreferences.getInstance();
    var idUser = prefs.getString('idUser');
    return idUser;
  }

  static remove() async{
    var prefs = await SharedPreferences.getInstance();
    await prefs.remove('idUser');

  }
}