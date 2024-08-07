// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
// ignore_for_file: sort_child_properties_last, deprecated_member_use

import 'package:flutter/material.dart';

import 'package:violet_wound/Utils/app_validator.dart';
import 'package:violet_wound/controllers/cadastro_controller.dart';
import '../Widgets/myTextForm.dart';

// ignore: camel_case_types
class Cadastro extends StatefulWidget {
  final String? nome;
  final String? email;
  const Cadastro({
    Key? key,
    this.nome,
    this.email,
  }) : super(key: key);


  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final CadastroController controller = CadastroController();

  final AppValidator controllerValidate = AppValidator();

  final _formKey = GlobalKey<FormState>();
  bool _showPassword = true;
  bool _showPassword2 = true;
  bool _showloading = true;

  @override
  Widget build(BuildContext context) {
    double? height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: height * 0.85,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            padding: const EdgeInsets.all(5.0),
                            alignment: Alignment.centerLeft,
                            splashRadius: 20.0,
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                            ),
                            onPressed: (() {
                              Navigator.pop(context);
                            }),
                          ),
                        ],
                      ),
                      Form(
                          key: _formKey,
                          child: Column(children: [
                            const Text(
                              'Criar conta',
                              style: TextStyle(fontSize: 20.0,fontFamily: 'Sen'),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            widget.nome != null ? myTextForm(
                              titulo: 'Nome',
                              initialValue: widget.nome,
                              validar: (p0) { 
                                AppValidator.validateName(p0!);
                                controller.crtName.text = p0;
                                return null;
                              },
                            ):
                            myTextForm(
                              titulo: 'Nome',
                              validar: (p0) => AppValidator.validateName(p0!),
                              controller: controller.crtName
                            )
                            ,
                            widget.email != null? myTextForm(
                              titulo: 'Email',
                              initialValue: widget.email,
                              validar: (p0) {
                                AppValidator.validateEmail(p0!);
                                controller.crtlEmail.text = p0;
                                return null;
                              },
                            ):
                            myTextForm(
                              titulo: 'Email',
                              validar: (p0) => AppValidator.validateEmail(p0!),
                              controller: controller.crtlEmail,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                    decoration:  InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,                                    
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                    hintText: 'Entre com a sua senha',
                                    suffixIcon: IconButton(
                                        icon: Icon(
                                          _showPassword == true ? Icons.visibility_off : Icons.visibility), 
                                        onPressed: () {
                                          setState(() {
                                            _showPassword = !_showPassword;
                                          });                                
                                        },                              
                                        splashRadius: 20.0,                         
                                      ),
                                ),
                                obscureText: _showPassword == false ? false : true,
                                validator: (value) => controllerValidate.validatePassword(value!),
                                controller: controller.crtlPassword,
                              ),
                            ),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: TextFormField(
                                decoration:  InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                hintText: 'Confirme a sua senha',
                                suffixIcon: IconButton(
                                    icon: Icon(
                                      _showPassword2 == true ? Icons.visibility_off : Icons.visibility), 
                                    onPressed: () {
                                      setState(() {
                                        _showPassword2 = !_showPassword2;
                                      });                                
                                    },                              
                                    splashRadius: 20.0,                         
                                  ),
                              ),
                              obscureText: _showPassword == false ? false : true,
                              validator: (value) => controllerValidate.validatePasswordEquals(value!),
                              controller: controller.crtlConfirmPassword,
                          ),
                           ),
                        ])),
                      const SizedBox(
                        height: 20.0,
                      ),
                      _showloading ? ElevatedButton(style: ElevatedButton.styleFrom(
                                primary: const Color.fromARGB(255, 39, 0, 79)
                              ),
                        child: const Text(
                        'Criar'),
                        onPressed: (() async {
                          setState(() { _showloading = !_showloading;});
                          try {
                            bool e = await controller.validar(_formKey, context);
                            if(e) {
                                showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    backgroundColor: Colors.black, // Define a cor de fundo preta
                                    insetPadding: EdgeInsets.zero, // Remove o espaçamento interno
                                    child: AlertDialog(
                                      title: const Text('Verifique o seu E-mail'),
                                      content: Text('Enviamos um link de verificação para ${controller.crtlEmail.text}. Verifique o seu e-mail e clique no link de verificação.'),
                                      actions: [
                                        TextButton(
                                          child: const Text('Ok'),
                                          onPressed: () {
                                            Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false); 
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                          } catch (e) {
                              showDialog(
                                context: context,
                                builder: (BuildContext dialogContext) {
                                  return AlertDialog(
                                    title: const Text('Erro'),
                                    content: Text(e.toString()),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Fechar'),
                                        onPressed: () {
                                          Navigator.of(dialogContext).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                            );
                          }
                          setState(() { _showloading = !_showloading;});
                        }),
                      ) : const CircularProgressIndicator(color: Color.fromARGB(255, 39, 0, 79)),
                
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Já tem conta?',
                      style: TextStyle(fontSize: 15.0,fontFamily: 'Sen'),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                          fontSize: 15.0,fontFamily: 'Sen'),
                      ),                                                
                      onPressed: (() {
                        Navigator.pop(context);
                      }),
                     child: const Text('Entrar'), 
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
