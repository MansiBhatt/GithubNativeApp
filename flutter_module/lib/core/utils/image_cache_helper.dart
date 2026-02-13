import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class ImageCacheHelper {
  static Future<String?> downloadImage(String url, String fileName) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final filePath = "${dir.path}/$fileName.png";

      final file = File(filePath);

      if (await file.exists()) {
        return filePath;
      }

      await Dio().download(url, filePath);

      return filePath;
    } catch (e) {
      return null;
    }
  }
}
