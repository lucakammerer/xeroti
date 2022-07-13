import 'dart:io';
import 'package:random_string/random_string.dart';
import 'package:image/image.dart' as I;
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import "dart:typed_data";
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Convert {

  Future convert (image, width, height, address) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      String file = "${randomAlphaNumeric(40) + ".jpeg"}";
      List rgbPixels = [];

      var _image = I.decodeImage(new File(image).readAsBytesSync())!;


      I.Image thumbnail = I.copyResize(_image, width: width, height: height);

      new File(directory.path + file)
        ..writeAsBytesSync(I.encodePng(thumbnail));


      int abgrToArgb(int argbColor) {
        int r = (argbColor >> 16) & 0xFF;
        int b = argbColor & 0xFF;
        return (argbColor & 0xFF00FF00) | (b << 16) | r;
      }

      Color getFlutterColor(int abgr) {
        int argb = abgrToArgb(abgr);
        return Color(argb);
      }

      I.Image img = I.decodeImage(File(directory.path + file).readAsBytesSync())!;
      for (int x =0; x<img.width; x++) {
        for(int y = 0; y<img.height; y++){
          int pixel = img.getPixelSafe(x,y);
          Color pixelColor = getFlutterColor(pixel);
          rgbPixels.add([pixelColor.red, pixelColor.green, pixelColor.blue]);
        }
      }

      return [thumbnail, directory.path + file, address, rgbPixels, width, height];
      await upload(thumbnail, directory.path + file, address, rgbPixels, width, height);
    } catch (e) {
      print(e);
    }
  }

  Future upload (image, imageUrl, address, rgbPixels, width, height) async {
    
    List pixelChunks = [];
    int chunkSize = 100;
    for (var i = 0; i < rgbPixels.length; i += chunkSize) {
      pixelChunks.add(rgbPixels.sublist(i, i + chunkSize > rgbPixels.length ? rgbPixels.length : i + chunkSize));
    }

    for (var i = 0; i < pixelChunks.length; i++) {
      await http.put(
        Uri.parse('http://${address}/json'),
        headers: <String, String>{
          'content-type': 'application/json',
        },
        body: jsonEncode(
          {
            'seg': {
              "id": i,
              "start": i * 100,
              "stop": (i * 100) + pixelChunks[i].length - 1,
              "i": pixelChunks[0]
            },
        
          }
        ),
      );
      await Future.delayed (Duration(seconds: 3));
    }
  }

}