import 'package:flutter/material.dart';
import 'package:xeroti/home/main.dart';

class Finish extends StatelessWidget {
  final dynamic cameras;
  final String result;
  Finish(this.cameras, this.result);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        children: [
          SizedBox(height: 30),
          Column(
            children: [
              Text("Finished", style: Theme.of(context).textTheme.headline6),
              Text("Your picture was uploaded.", style: Theme.of(context).textTheme.bodyText2),
              Text(result)
            ],
          ),
          Image.asset("assets/finish.png"),
          SizedBox(height: 20),
          Center(
            child: Container(
              height: 46,
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Home(this.cameras))),
                child: Text("Back to home"),
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
        ],
      ),
    );
  }
}
