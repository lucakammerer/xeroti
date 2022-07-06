import 'dart:io';
import 'package:random_string/random_string.dart';
import 'package:image/image.dart' as I;
import 'package:path_provider/path_provider.dart';
import 'dart:async';
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
      for(int x =0;x<img.width;x++) {
        for(int y = 0;y<img.height;y++){
          int pixel = img.getPixelSafe(x,y);
          Color pixelColor = getFlutterColor(pixel);
          rgbPixels.add([pixelColor.red, pixelColor.green, pixelColor.blue]);
        }
      }


      await upload(thumbnail, directory.path + file, address, rgbPixels, width, height);
    } catch (e) {
      print(e);
    }
  }

  Future upload (image, imageUrl, address, rgbPixels, width, height) async {
    List items = List.generate(10 - 1, (index) =>
      { "start": index, "stop": index + 1, "len": 20, "col": [ rgbPixels[index], rgbPixels[index], rgbPixels[index]], "fx": 0, "sx": 127, "ix": 127, "pal": 0, "sel": true, "rev": false, "cln": -1 },
    );

    items.add(
      {
        "start": 10 - 1, "stop": 11, "len": 20, "col": [ rgbPixels[(width * height) - 1], rgbPixels[(width * height) - 1], rgbPixels[(width * height) - 1]], "fx": 0, "sx": 127, "ix": 127, "pal": 0, "sel": true, "rev": false, "cln": -1
      }
    );


      await http.post(
        Uri.parse('http://4.3.2.1/json/'),
        headers: <String, String>{
          'content-type': 'application/json',
        },
        body: jsonEncode({
          'seg': items,
        }),
      );


    /**if (request.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return request.body;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print("failed to load");
      return "Failed to load";
    }**/
  }

}