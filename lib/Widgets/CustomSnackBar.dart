// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  const CustomSnackBar({
    Key? key, required this.title
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 50,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 3, 167, 118),
          borderRadius: BorderRadius.circular(5)),
      child:  Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: 'Sen'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
