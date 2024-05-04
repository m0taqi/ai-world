import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'const.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Generation App',
      home: photo(),
    );
  }
}

class photo extends StatefulWidget {
  @override
  _photoState createState() => _photoState();
}

class _photoState extends State<photo> {
  final TextEditingController _textController = TextEditingController();
  String _generatedImageUrl = '';

  Future<void> generateImage() async {
    const String apiKey = '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'; // Replace with your OpenAI API key
    final String prompt = _textController.text.toString();

    // Make a POST request to OpenAI API to generate image
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/images/generations'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'prompt': prompt,
        'quality':'hd',
        "n": 1,
      }),
    );

    if (response.statusCode == 200) {
      // Parse the API response and update the generated image URL

      final responseData = jsonDecode(response.body);
      setState(() {
        _generatedImageUrl = responseData['data'][0]['url'];
      });
    } else {
      // Handle API error
      print('Error generating image: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: l2,
      appBar:AppBar(
        centerTitle: true,
        title:  Text(
          "AI Image",
          style: TextStyle(color: Color(0xffbde0fe), fontSize: 28),
        ),
        backgroundColor: app,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
            children: [
              // Text input field for entering the prompt
              TextField(style: TextStyle(color: txt,fontSize: 20),
                controller: _textController,
                decoration:  InputDecoration(
                    hintText: 'How I Can Help You!',hintStyle: TextStyle(color: txt)
                ),

                ),


              // Button to trigger image generation
              SizedBox(height: 12,),
             ElevatedButton(
                          onPressed: generateImage,
                          child:  Text(
                          "Get Result",
                          style: TextStyle(
                          color: txt,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                      backgroundColor: app
                      ),
                      ),
                                SizedBox(height: 16),
              // Display the generated image if available
              if (_generatedImageUrl.isNotEmpty)
               Container(decoration: BoxDecoration(border:Border.all(width: 4,color: txt)),
                   child: FadeInImage.assetNetwork(placeholder: 'images/load.gif', image: _generatedImageUrl,))

            ],
          ),
      ),
      );



  }
}