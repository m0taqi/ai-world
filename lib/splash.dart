import 'dart:async';
import 'package:flutter/material.dart';
import 'intro.dart';
class splash extends StatefulWidget {
  const splash({super.key});

  @override
  _splashState createState() => _splashState();
}
class _splashState extends State<splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                    onBoardingPage()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container( decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage("images/ss.gif"),
        fit: BoxFit.cover,
      ),
    ),
    );
  }
}
