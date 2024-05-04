import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'const.dart';



class QuoteGenerator extends StatefulWidget {
  const QuoteGenerator({super.key});

  @override
  State<QuoteGenerator> createState() => _QuoteGeneratorState();
}

class _QuoteGeneratorState extends State<QuoteGenerator> {
  final String quoteURL = "https://api.adviceslip.com/advice";
  String quote = 'Press Button ';

  Future<void> generateQuote() async {
    try {
      final response = await http.get(Uri.parse(quoteURL));
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        setState(() {
          quote = result["slip"]["advice"];
        });
      } else {
        setState(() {
          quote = 'Failed to fetch quote';
        });
      }
    } catch (e) {
      setState(() {
        quote = 'Failed to fetch quote';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        centerTitle: true,
        title:  Text(
          "Quote Advice ",
          style: TextStyle(color:txt, fontSize: 28),
        ),
        backgroundColor: app,
      ),
      body:  Container(  decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/q.jpg"),
          fit: BoxFit.cover,
        ),
      ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  quote, style: TextStyle(color: txt, fontSize: 30),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    generateQuote();
                  },
                  child: Text('Take Advice',
                    style: TextStyle(color: txt, fontSize: 20),),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: app
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}