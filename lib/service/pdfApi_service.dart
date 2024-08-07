// ignore_for_file: file_names

import 'dart:io';
import 'dart:typed_data';
//import 'package:open_document/open_document.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class PdfApi {
  static Future<void> saveDocument({
    required String name,
    required Uint8List bytes,
  }) async {
    final dir = await getTemporaryDirectory();
    final filePath = '${dir.path}/$name';
    final file = File(filePath);
    await file.writeAsBytes(bytes);
    await OpenFile.open(file.path);
    await OpenFile.open(filePath);
    
  }

}