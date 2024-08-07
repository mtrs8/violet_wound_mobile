// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget myTextForm(
    {String? titulo,
    String? hinttext,
    // ignore: non_constant_identifier_names
    String? Function(String?)? validar, Widget? picon, IconButton? piconitingController, controller, Widget? sicon, double? width, TextInputType? keyboardType, int? maxLength, List<TextInputFormatter>? inputFormatters, void Function()? onTap, String? initialValue}) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: width,
        child: TextFormField(
            // ignore: unnecessary_type_check
            initialValue: initialValue,
            inputFormatters: inputFormatters,
            maxLength: maxLength,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              filled: true,
              labelText: titulo,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              hintText: hinttext,
              isDense: true,
              contentPadding: const EdgeInsets.all(15),
              prefixIcon: picon,
              suffixIcon: sicon,
            ),
            controller: controller,
            validator: validar,
            ),
      ),
    ),
  );
}