// ignore_for_file: file_names, prefer_typing_uninitialized_variables, nullable_type_in_catch_clause, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:violet_wound/controllers/paciente_controller.dart';
import 'package:violet_wound/models/pacientes.dart';
import 'package:violet_wound/views/prontuarioPaciente_view.dart';

// ignore: must_be_immutable
class ContainerPaciente extends StatefulWidget {
  final Pacientes paciente;
  final String idUser;
  final int index;
  const ContainerPaciente(this.paciente,
      {Key? key, required this.idUser, required this.index})
      : super(key: key);
  @override
  State<ContainerPaciente> createState() => _ContainerPacienteState();
}

class _ContainerPacienteState extends State<ContainerPaciente> {
  PacienteController controller = PacienteController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double? width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProntuarioPaciente(
              paciente: widget.paciente, idUser: widget.idUser);
        }));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: EdgeInsets.all(width * 0.05),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 60, 0, 122),
              borderRadius: BorderRadius.circular(15),
              shape: BoxShape.rectangle,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: width * 0.15,
                      child: Text(widget.paciente.nome,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20.0,fontFamily: 'Sen'),
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: PopupMenuButton(
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem(
                            value: 'Apagar', child: Text('Apagar')),
                      ];
                    },
                    onSelected: (value) {
                      if (value == 'Apagar') {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Apagar Paciente'),
                              content: const Text('Deseja apagar o paciente?'),
                              actions: [
                                TextButton(
                                    onPressed: () async {
                                      var message;
                                      try {
                                        await context.read<PacienteController>().removePaciente(
                                                widget.idUser, widget.index)
                                            .then((value) => message = value);
                                      } on dynamic catch (e) {
                                        message = e;
                                      } finally {
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                                      }
                                    },
                                    child: const Text('Sim')),
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Não')),
                              ],
                            );
                          },
                        );
                      }
                    },
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
