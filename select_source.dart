import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:xeroti/home/camera.dart';
import 'package:xeroti/home/input.dart';
import 'package:image_picker/image_picker.dart';

class SelectSource extends StatefulWidget {
  final dynamic cameras;
  final String image;
  SelectSource({this.cameras, required this.image});

  @override
  State<SelectSource> createState() => _SelectSourceState();
}

class _SelectSourceState extends State<SelectSource> {
  @override
  Widget build(BuildContext context) {
    String _image = widget.image;
    PickedFile _imageFile;
    final ImagePicker _picker = ImagePicker();

    if (widget.image == "") {
      _image = "assets/placeholder.png";
    }

    _pickImage() async {
      try {
        final pickedFile = await _picker.getImage(source: ImageSource.gallery);
        _imageFile = pickedFile!;
        await Future.delayed(Duration(seconds: 2));
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => SelectSource(image: _imageFile.path)));
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(CupertinoIcons.back),
        ),
        elevation: 0.0,
      ),
      body: ListView(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        children: [
          widget.image == ""
            ? Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.width, child: Image.asset(_image))
            : Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.width, child: Image.file(File(_image))),
          SizedBox(height: 30),
          Center(
            child: Container(
              height: 46,
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                onPressed: () async {
                  await _pickImage();
                },
                child: Text("Select image from gallery"),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(29.0),
                          side: BorderSide(color: Theme.of(context).accentColor)
                      )
                  ),
                  backgroundColor: MaterialStateProperty.all(Theme.of(context).accentColor),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text("OR", style: Theme.of(context).textTheme.bodyText1, textAlign: TextAlign.center),
          ),
          Center(
            child: Container(
              height: 46,
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Camera(cameras: widget.cameras))),
                child: Text("Take a photo", style: TextStyle(color: Theme.of(context).cardColor)),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(29.0),
                          side: BorderSide(color: Theme.of(context).backgroundColor)
                      )
                  ),
                  backgroundColor: MaterialStateProperty.all(Theme.of(context).backgroundColor),
                ),
              ),
            ),
          ),
          widget.image != ""
            ? TextButton.icon(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Input(imagePath: _image, cameras: widget.cameras,))),
                icon: Icon(CupertinoIcons.arrow_right, color: Theme.of(context).accentColor),
                label: Text("Convert this image", style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Theme.of(context).accentColor, fontWeight: FontWeight.bold)))
            : TextButton.icon(
              onPressed: () {},
              icon: Icon(CupertinoIcons.arrow_right, color: Theme.of(context).backgroundColor),
              label: Text("Convert this image", style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Theme.of(context).backgroundColor, fontWeight: FontWeight.bold))
            ),
        ],
      )
    );
  }
}
