// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:violet_wound/controllers/feridas_controller.dart';
import 'package:violet_wound/service/api_service.dart';

class ControllerCamera extends ChangeNotifier {
  late File arquivo;
  ImagePicker imagePicker = ImagePicker();
  FeridasController controller = FeridasController();
  ApiService service = ApiService();

  getGallery() async {
    final XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporary = File(image.path);
    return imageTemporary;
  }

  getCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTemporary = File(image.path);
    return imageTemporary;
  }
}
