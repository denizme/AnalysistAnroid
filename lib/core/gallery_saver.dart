import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class GallerySaver {
  Future<bool> savePhoto(String photoLink) async {
    try {
      var response = await Dio()
          .get(photoLink, options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 100,
          name: DateTime.now().toIso8601String());

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> saveVideo(String videoLink) async {
    try {
      var appDocDir = await getTemporaryDirectory();
      String savePath = "${appDocDir.path}/temp.mp4";
      await Dio().download(videoLink, savePath);
      final result = await ImageGallerySaver.saveFile(savePath);
      print(result);
      return true;
    } catch (e) {
      return false;
    }
  }
}
