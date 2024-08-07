// ignore_for_file: file_names, use_build_context_synchronously, unnecessary_null_comparison, unused_local_

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class MyShimmer extends StatelessWidget {
  const MyShimmer({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    double? width = MediaQuery.of(context).size.width;
    double? height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar( 
        backgroundColor:const Color.fromARGB(255, 39, 0, 79),
        automaticallyImplyLeading: false,
        shadowColor: const Color.fromARGB(255, 39, 0, 79),
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                  onPressed: (){},
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xFFc5e5f3),
                  ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            color: Colors.white,
            child: Stack(
              children: [
                const SizedBox(width: 30),
                Container(
                  height: height * 0.4,
                  width: width,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(255, 39, 0, 79),
                          Color.fromARGB(255, 85, 15, 155),
                        ]),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 10),
                    Container(
                        width: width,
                        height: 320,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(left: 25, right: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 25,
                                spreadRadius: 1,
                                offset: const Offset(-10, 0),
                                color: Colors.black.withOpacity(0.2)),
                          ],
                        ),                        
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 15),
                            myContainerWithShimmer(30, 260),
                            myContainerWithShimmer(30, 260),
                            myContainerWithShimmer(30, 260),
                            myContainerWithShimmer(30, 260),
                            myContainerWithShimmer(30, 260),
                            myContainerWithShimmer(30, 260),
                          ]
                        ),
                      ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 40, top: 20),
                          child: Text(
                            "FERIDAS",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20,fontFamily: 'Sen'),
                          ),
                        ),
                        Container(
                            width: width,
                            height: height * 0.25,
                            margin: const EdgeInsets.only(
                                left: 25, right: 25, bottom: 25, top: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 25,
                                    spreadRadius: 1,
                                    offset: const Offset(-10, 0),
                                    color: Colors.black.withOpacity(0.2)),
                              ],
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                                    child: myContainerWithShimmer(60, 360),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 20 ),
                                    child: myContainerWithShimmer(60, 360),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 20 ),
                                    child: myContainerWithShimmer(60, 360),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
      ),
    );
  }
}

Widget myContainerWithShimmer(double height, double width){
  return Column(
    children: [
      Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade200,
        child: Container(
          height: height,
          width: width,                             
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
      const SizedBox(height: 15)
    ],
  );
                           
}
