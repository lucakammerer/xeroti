import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xeroti/home/finish.dart';
import 'package:xeroti/services/convert.dart';
import 'package:flutter/services.dart';

class Input extends StatefulWidget {
  final String imagePath;
  final dynamic cameras;
  Input({required this.imagePath, this.cameras});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  final _formKey = GlobalKey<FormState>();
  String _error = "";
  int _pixelWidth = 0;
  int _pixelHeight = 0;
  String _address = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0.0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(10),
          physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          children: [
            Text("Enter WLED data", style: Theme.of(context).textTheme.headline6, textAlign: TextAlign.center),
            SizedBox(height: 50),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Color.fromRGBO(230, 49, 255, 0.2),
                borderRadius: BorderRadius.circular(29),
              ),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.width_full_rounded, color: Theme.of(context).accentColor),
                  hintText: "Width in pixels",
                  hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                  border: InputBorder.none,
                  errorMaxLines: 10,
                ),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                validator: (val) {
                  if (val!.isEmpty) {return "Please enter a pixel width";}
                  else{return null;}
                },
                onChanged: (val){
                  setState(() => _pixelWidth = int.parse(val));
                },
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Color.fromRGBO(230, 49, 255, 0.2),
                borderRadius: BorderRadius.circular(29),
              ),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.height, color: Theme.of(context).accentColor),
                  hintText: "Height in pixels",
                  hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                  border: InputBorder.none,
                  errorMaxLines: 10,
                ),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                validator: (val) {
                  if (val!.isEmpty) {return "Please enter a pixel width";}
                  else{return null;}
                },
                onChanged: (val){
                  setState(() => _pixelHeight = int.parse(val));
                },
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Color.fromRGBO(230, 49, 255, 0.2),
                borderRadius: BorderRadius.circular(29),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.height, color: Theme.of(context).accentColor),
                  hintText: "IP of your device (usually 4.3.2.1)",
                  hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                  border: InputBorder.none,
                  errorMaxLines: 10,
                ),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                validator: (val) {
                  if (val!.isEmpty) {return "Please enter the device IP";}
                  else{return null;}
                },
                onChanged: (val){
                  setState(() => _address = val);
                },
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Container(
                height: 46,
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()){
                      try{
                        String result = await Convert().convert(widget.imagePath, _pixelWidth, _pixelHeight, _address);
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Finish(widget.cameras, result)));
                      } catch(e){
                        if(e is PlatformException){
                          setState(() {
                            _error = e.code;
                          });
                        }
                      }
                    } else{
                      setState(() {
                        _error = "Please fill in all fields.";
                      });
                    }
                  },
                  child: Text("Convert image"),
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
              padding: EdgeInsets.all(20),
              child:  Text(
                _error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            )
          ],
        ),
      )
    );
  }
}
