// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class ShimmerHomePage extends StatelessWidget {
  const ShimmerHomePage({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return GridView.builder(            
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0),
      itemCount: 8,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              margin: const EdgeInsets.all(0.1),
              height: 100.0,
              decoration: BoxDecoration(
                color: Colors.white,
                // Color.fromARGB(255, 67, 6, 128),
                borderRadius: BorderRadius.circular(15),
                shape: BoxShape.rectangle,
              ),
            ),
          ),
        ),
      )
    );
  }
}
