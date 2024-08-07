// ignore_for_file: file_names

import 'package:flutter/material.dart';

/// Cria área expansível customizável
/// {@category Components}
class CustomExpansionTile extends StatelessWidget {
  final List<Widget> children;
  final String? title;

  const CustomExpansionTile({Key? key, 
    required this.children,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Container(
        margin: const EdgeInsets.all(5),
        width: size.width * 1,
        child: ExpansionTile(
          initiallyExpanded: true,
          title: Text(title!,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,fontFamily: 'Sen')),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(children: children),
            ),
          ],
        ),
      ),
    );
  }
}
