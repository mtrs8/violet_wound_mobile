// ignore_for_file: sort_child_properties_last, prefer_final_fields, deprecated_member_use, depend_on_referenced_packages, nullable_type_in_catch_clause, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:violet_wound/Utils/app_validator.dart';
import 'package:violet_wound/controllers/login_controller.dart';
import 'package:violet_wound/views/cadastro_view.dart';

// ignore: must_be_immutable
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);


  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
  

  final LoginController controller = LoginController();
  final AppValidator controllerValidate = AppValidator();
  bool _showPassword = true;
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
                  children:  [
                     SizedBox(
                      height: height * 0.8,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: const Image(
                                image: AssetImage('assets/logo.png'),
                                height: 120.0,
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            const Text(
                              'Fazer login',
                              style: TextStyle(fontSize: 20.0,fontFamily: 'Sen'),
                            ),
                            const SizedBox(
                              height: 80.0,
                            ),
                            Form(
                              key: _formKey,
                              child: Column(children: [
                                  Form(
                                    key: _emailFormKey,
                                    child: TextFormField(                          
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(),
                                        hintText: 'Entre com seu e-mail',                          
                                        ),
                                    validator: (value) => AppValidator.validateEmail(value!),
                                    controller: controller.crtEmail,
                                                          ),
                                  ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                TextFormField(
                                  decoration:  InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: const OutlineInputBorder(),
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
                                  controller: controller.crtSenha,
                                ),
                              ])
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Center(
                              child: _showloading ? ElevatedButton(style: ElevatedButton.styleFrom(
                                  primary: const Color.fromARGB(255, 39, 0, 79)
                                ),
                                  child: const Text('Login'),
                                  onPressed: (() async {
                                    setState(() { _showloading = !_showloading;});
                                    try {
                                      var idUser = await controller.validar(_formKey, _emailFormKey,context);
                                      if(idUser.isNotEmpty){
                                        Navigator.of(context).pushReplacementNamed('/home', arguments: idUser);
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
                                                  child: const Text('Fechar', style: TextStyle(color: Color.fromARGB(255, 39, 0, 79),fontFamily: 'Sen'),),
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
                                ) : const CircularProgressIndicator(color: Color.fromARGB(255, 39, 0, 79))
                            ),
                          ],
                        ),
                     ),
                    //SizedBox(height: height*0.15),
                    Align(
                      alignment: Alignment.bottomRight,    
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: MaterialButton(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0), 
                              side: const BorderSide(color: Colors.black, width: 1.0), 
                            ),
                            onPressed: ()async {
                              try {
                                await LoginController.signInWithGoogle(context);
                              } on dynamic catch (e) {  
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(e.toString()),
                                  duration: const Duration(seconds: 2),
                                  ));
                              }                              
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 30.0,
                                    width: 30.0,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                              AssetImage('assets/googleimage.png'),
                                          fit: BoxFit.cover),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const Text("Entrar com o Google")
                                ],
                              ),
                            )
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                              style: TextButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 15,fontFamily: 'Sen'),
                              ),
                              onPressed: () {                                
                                Navigator.push(context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const Cadastro();
                                    }));
                              },
                              child: const Text('Criar Conta'),
                              ),
                              TextButton(
                              style: TextButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 15,fontFamily: 'Sen'),
                              ),
                              onPressed: () async {                          
                                if (_emailFormKey.currentState!.validate()){  
                                  await controller.resetPassword();                                                               
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    duration: Duration(seconds: 5),
                                    content: Text("E-mail de redefinição de senha enviado.")));                                  
                                }
                              },
                              child: const Text('Esqueceu a senha?'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),                    
                  ],
                ),
              ),
            ),
          ),
        );
  }
}