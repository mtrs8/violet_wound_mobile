import 'package:flutter/material.dart';
import 'package:violet_wound/service/prefs_service.dart';
import 'package:violet_wound/views/homePage_view.dart';
import 'package:violet_wound/views/login_view.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<String?>(
        future: searchId(),
        builder: (context, snapshot){
          final status = snapshot.connectionState;
    
          if (status == ConnectionState.waiting || status == snapshot.error) {          
            return splash();
          }
    
          var id = snapshot.data;
          return id == null ? const Login() : HomePage(idUser: id);
        }
      ),
    );
  }
  Future<String?> searchId()async{
    var id = await SharedPreference.getId();
        await Future.delayed(const Duration(seconds: 2));

    return id;
  }

  Widget splash() {
    return Container(
      color: Colors.white,
      child: const Center(child: Image(image: AssetImage('assets/logo_copy.png'))),
    );
  }
}


