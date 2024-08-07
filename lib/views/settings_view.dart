// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:violet_wound/controllers/login_controller.dart';
// import 'package:violet_wound/telas/principal.dart';

// ignore: camel_case_types
class Settings extends StatelessWidget {
  final String? nomeUser;

  const Settings({Key? key, this.nomeUser}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios_new)),
        title: const Center(child: Text("Configurações")),
        backgroundColor: const Color.fromARGB(255, 39, 0, 79),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                      height: 100,
                      width: 75,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 236, 236, 236),
                      ),
                      child: const Icon(
                        Icons.person,
                        color:  Color.fromARGB(255, 39, 0, 79),
                        size: 30,
                      ),                
                    ),
                ),
                Text(nomeUser??'', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20,fontFamily: 'Sen'),),
              ],
            ),
            const Divider(
              height: 20,
              thickness: 1,
              indent: 15,
              endIndent: 15,
              color: Colors.grey,
            ),
            // GestureDetector(
            //   onTap: () {},
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Container(
            //       padding: const EdgeInsets.all(10),
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(10),
            //         color: const Color.fromARGB(255, 249, 250, 252),
            //       ),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children:  [
            //           Text("Editar Conta", style: TextStyle(
            //             fontSize: 20,
            //             fontWeight: FontWeight.w400,
            //             color: Colors.grey[600],
            //           ),),
            //           const Icon(Icons.arrow_forward_ios, color: Colors.grey)
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // GestureDetector(
            //   onTap: () {},
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Container(
            //       padding: const EdgeInsets.all(10),
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(10),
            //         color: const Color.fromARGB(255, 249, 250, 252),
            //       ),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children:  [
            //           Text("Mudar Senha", style: TextStyle(
            //             fontSize: 20,
            //             fontWeight: FontWeight.w400,
            //             color: Colors.grey[600],
            //           ),),
            //           const Icon(Icons.arrow_forward_ios, color: Colors.grey)
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder:(context) {
                    return AlertDialog(
                      title: const Text('Deseja sair da conta?'),
                      actions: [
                          TextButton(
                              onPressed: () async{
                                LoginController.logOut();
                                Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false); 
                                
                              },
                              child: const Text('Sair')),
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancelar')),
                      ],
                    );  
                  },
                );                
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 249, 250, 252),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Text("Sair da Conta", style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                      ),),
                      const Icon(Icons.arrow_forward_ios, color: Colors.grey)
                    ],
                  ),
                ),
              ),
            ),          
          ],
        ),
      )
    );
  }
}
