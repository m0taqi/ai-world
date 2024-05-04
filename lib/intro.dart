import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'const.dart';
import 'chose.dart';
class onBoardingPage extends StatelessWidget {
  const onBoardingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: 'WELCOME TO AI World',
          body: 'This app Content The Most Use AI Tools',
          image: buildImage('images/1.gif'),
          decoration: buildDecoration(),
        ),
        PageViewModel(
          title: 'Free USE!',
          body: 'No need For subscription Just feel Free for Use Our Application',
          image: buildImage('images/2.gif'),
          decoration: buildDecoration(),
        ),
        PageViewModel(
          title: 'Tools That We Offer ',
          body: 'AI CHAT BOT, AI Image Generator, Advance Generator, Audio File Extracted to text',
          image: buildImage('images/3.gif'),
          decoration: buildDecoration(),
        ),
        PageViewModel(
          title: 'ENJOY OUR WORLD',
          body: 'Enjoy Using Future World \n (All world in Your Hand)',
          image: buildImage('images/4.gif'),
          decoration: buildDecoration(),
        ),
      ],
      next: Icon(Icons.navigate_next, size: 40, color: txt,),
      done: Text('Done', style: TextStyle(color: txt, fontSize: 20)),
      onDone: () => goToHome(context),
      showSkipButton: true,
      skip: Text('Skip', style: TextStyle(color: txt, fontSize: 20),), //by default, skip goes to the last page
      onSkip: () => goToHome(context),
      dotsDecorator: getDotDecoration(),
      animationDuration: 1000,
      globalBackgroundColor: tex,
    );
  }

  DotsDecorator getDotDecoration() => DotsDecorator(
      color: Colors.grey,
      size: Size(10,10),
      activeColor: txt,
      activeSize: Size(22,10),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      )

  );
  void goToHome(BuildContext context) => Navigator.of(context).pushReplacement(

      MaterialPageRoute(builder: (_) => chose()));

  Widget buildImage(String path) => Center(
      child: Image.asset(path)
  );

  PageDecoration buildDecoration() => PageDecoration(
    titleTextStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color:txt),
    bodyTextStyle: TextStyle(fontSize: 20,color: txt),
    pageColor: app,
    imagePadding: EdgeInsets.all(0),
  );
}