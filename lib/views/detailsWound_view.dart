// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names, must_be_immutable
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';


class DetailsWound extends StatefulWidget {
  String imageurl;
  DetailsWound({
    Key? key,
    required this.imageurl,
  }) : super(key: key);

  @override
  State<DetailsWound> createState() => _DetailsWoundState();
}

class _DetailsWoundState extends State<DetailsWound>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PhotoView(
        imageProvider: NetworkImage(widget.imageurl),
        loadingBuilder: (context, event) => const Center(
            child: LinearProgressIndicator(),
          ),
        )
      )
    );
  }
}
