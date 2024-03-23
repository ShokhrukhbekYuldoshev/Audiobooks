import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

Future<bool> isFileExists(String fileName) async {
  final directory = await getExternalStorageDirectory();
  final filePath = '${directory!.path}/$fileName';
  final file = File(filePath);
  return file.exists();
}

bool canLoadImage(String image) {
  if (image.isEmpty) {
    return false;
  }
  return true;
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
