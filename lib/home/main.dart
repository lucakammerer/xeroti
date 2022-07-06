import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xeroti/home/select_source.dart';
import 'package:xeroti/services/convert.dart';

class Home extends StatefulWidget {
  final dynamic cameras;
  Home(this.cameras);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(12),
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        children: [
          SizedBox(height: 30),
          Column(
            children: [
              Text("Xeroti", style: Theme.of(context).textTheme.headline3),
              Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Image.asset("assets/logo_transparent.png")
              ),
            ],
          ),
          SizedBox(height: 20),
          Text("Info", style: Theme.of(context).textTheme.headline6),
          Text("Xeroti is an app designed to serve as an extension to WLED. With this app you can take pictures, convert them down to a selected pixel size and send them to your NeoPixel device.\n\nBefore using it, you should consider the following things:\n\n1. Your NeoPixel device is turned on and has a pixel size of 1:1\n\n2. You are connected to your device via the WLED network\n\n3. You have selected the correct pixel size for the connection", style: Theme.of(context).textTheme.bodyText2),
          SizedBox(height: 20),
          Center(
            child: Container(
              height: 46,
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SelectSource(image: "", cameras: widget.cameras))),
                child: Text("Start now!"),
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
          SizedBox(height: 20),
          Center(
            child: Container(
              height: 46,
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                onPressed: () async => await launchUrl(Uri.parse("https://www.luca-kammerer.de/")),
                child: Text("Support the Developer", style: TextStyle(color: Theme.of(context).cardColor)),
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
        ],
      ),
    );
  }
}
