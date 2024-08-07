// ignore_for_file: depend_on_referenced_packages, nullable_type_in_catch_clause

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:violet_wound/Widgets/noInternet.dart';
import 'package:violet_wound/models/feridas.dart';
import 'package:violet_wound/models/pacientes.dart';
import 'package:violet_wound/models/user.dart';

class ApiService {
  //Ao realizar deploy da api para o server, substituir essa URL
  //final address = "http://10.0.0.105:5000"; //URL Local Matheus
  //final address = "http://10.10.1.219:5000";  //URL Local Victor
  final address = "http://api.computacaobrasil.com.br:8000/api/violetwound";
  // final address = "http://localhost:8000/api/violetwound/ ";

  Future addPaciente(Pacientes paciente, String id) async {
    try {
      bool? hasinternet = await NoInternet.checkInternetConnection();
      if (hasinternet) {
        var dados = paciente.toMap();
        final url = Uri.parse("$address/adicionarPaciente");
        var request =
            await http.post(url, body: {'dados': json.encode(dados), 'id': id});
        if (request.statusCode == 200) {
          return jsonDecode(request.body);
        }
        throw Exception(request.body);
      } else {
        throw Exception("Sem conexão com a internet");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future editPaciente(Pacientes paciente, String idUser) async {
    try {
      bool? hasinternet = await NoInternet.checkInternetConnection();
      if (hasinternet) {
        var dados = paciente.toMap();
        final url = Uri.parse("$address/editarPaciente");
        var request = await http.put(url, body: {
          "key": paciente.iD!,
          "dados": json.encode(dados),
          "idUser": idUser
        });
        if (request.statusCode != 200) {
          throw Exception(request.body);
        }
      } else {
        throw Exception("Sem conexão com a internet");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future removePaciente(String key, int index) async {
    final url = Uri.parse("$address/excluirPaciente");
    try {
      bool? hasinternet = await NoInternet.checkInternetConnection();
      if (hasinternet) {
        var request =  await http.delete(url, body: {"key": key, "index": index.toString()});
        if (request.statusCode == 200) {
          return jsonDecode(request.body);
        }
        throw Exception(request.body);
      } else {
        throw Exception("Sem conexão com a internet");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> getUser(String idUser) async {
    try {
      bool? hasinternet = await NoInternet.checkInternetConnection();
      if (hasinternet) {
        final url = Uri.parse("$address/getPacientes");
        final responsed = await http.get(url, headers: {'id': idUser});

        if (responsed.statusCode == 200) {
          var list = jsonDecode(responsed.body);
          User user = User.fromMap(list);
          return user;
        }
        throw Exception(responsed.body);
      } else {
        await Future.delayed(const Duration(seconds: 1));
        throw Exception("Sem conexão com a internet");
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<Pacientes?> getPaciente(String? key, String? idUser) async {
    try {
      bool? hasinternet = await NoInternet.checkInternetConnection();
      if (hasinternet) {
        final url = Uri.parse("$address/getPaciente");
        var request = await http.get(url, headers: {"keyPaciente": key!, "idUser": idUser!});
        if (request.statusCode == 200) {
          Pacientes paciente = Pacientes.fromMap(jsonDecode(request.body));
          await Future.delayed(const Duration(seconds: 1));
          return paciente;
        }
        throw Exception(request.body);
      } else {
        await Future.delayed(const Duration(seconds: 1));
        throw Exception("Sem conexão com a internet");
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<Wound?> addFerida(
      Wound wound, String iD, File userImage, String idUser) async {
    var header = {
      "Content-Type": "multipart/form-data; charset=UTF-8",
      "Connection": "Keep-Alive",
      "Keep-Alive": "timeout=30, max=2000"
    };
    try {
      bool? hasinternet = await NoInternet.checkInternetConnection();
      if (hasinternet) {
        var dados = wound.toMap();
        final url = Uri.parse("$address/adicionarFerida");
        var sentContent =
            await http.MultipartFile.fromPath("userImage", userImage.path);

        var request = http.MultipartRequest("POST", url);
        request.files.add(sentContent);
        request.fields['dados'] = json.encode(dados);
        request.fields['key'] = iD;
        request.fields['idUser'] = idUser;
        request.headers.addAll(header);
        var apiResponse = await request.send();
        final responsed = await http.Response.fromStream(apiResponse);
        if (apiResponse.statusCode == 200) {
          Wound wound = Wound.fromMap(jsonDecode(responsed.body));
          return wound;
        }
        throw Exception(responsed.body);
      } else {
        throw Exception("Sem conexão com a internet");
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future removeferida(String key, String idUser, int index) async {
    try {
      bool? hasinternet = await NoInternet.checkInternetConnection();
      if (hasinternet) {
        final url = Uri.parse("$address/excluirFerida");
        var response = await http.delete(url,
            body: {"key": key, "idUser": idUser, "index": index.toString()});
        if (response.statusCode == 200) {
          return jsonDecode(response.body);
        }
        throw Exception(response.body);
      } else {
        throw Exception("Sem conexão com internet");
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<Map> login(String email, String senha) async {
    try {
      bool? hasinternet = await NoInternet.checkInternetConnection();
      if (hasinternet) {
        final url = Uri.parse("$address/EntrarConta");
        final responsed =
            await http.get(url, headers: {"email": email, "senha": senha});
        if (responsed.statusCode == 200) {
          return jsonDecode(responsed.body);
        }
        throw Exception(responsed.body);
      } else {
        throw Exception("Sem conexão com a internet");
      }
    } on dynamic catch (e) {
      throw e.message;
    }
  }

  Future<String?> loginWithGoogle(String email, String nome) async {
    try {
      bool? hasinternet = await NoInternet.checkInternetConnection();
      if (hasinternet) {
        final url = Uri.parse("$address/loginWithGoogle");
        final responsed =
            await http.get(url, headers: {"email": email, "nome": nome});
        if (responsed.statusCode == 200) {
          var data = jsonDecode(responsed.body);

          return data["id"];
        }
        if (responsed.statusCode == 404) {
          return null;
        }
        throw Exception(responsed.body);
      } else {
        throw Exception("Sem conexão com a internet");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map> criarConta(User user) async {
    try {
      bool? hasinternet = await NoInternet.checkInternetConnection();
      if (hasinternet) {
        var userMap = user.toMap();
        final url = Uri.parse("$address/criarConta");
        final responsed =
            await http.post(url, body: {"dados": json.encode(userMap)});
        if (responsed.statusCode == 200) {
          return jsonDecode(responsed.body);
        }
        throw Exception(responsed.body);
      } else {
        throw Exception("Sem conexão com a internet");
      }
    } on dynamic catch (e) {
      throw e.message;
    }
  }

  Future<Map> resetSenha(String email) async {
    try {
      bool? hasinternet = await NoInternet.checkInternetConnection();
      if (hasinternet) {
        final url = Uri.parse("$address/RedefinirSenha");
        final responsed = await http.post(url, body: {"email": email});
        if (responsed.statusCode == 200) {
          return jsonDecode(responsed.body);
        }
        throw Exception(responsed.body);
      } else {
        throw Exception("Sem conexão com a internet");
      }
    } on dynamic catch (e) {
      throw e.message;
    }
  }
}
