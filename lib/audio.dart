import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'const.dart';

class audio extends StatefulWidget {
  const audio({super.key});

  @override
  State<audio> createState() => _audioState();
}

class _audioState extends State<audio> {
  var text = "Chose File Please ";

  Future<String> convertSpeechToText(String filePath) async {
    const apiKey = "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";
    var url = Uri.https("api.openai.com", "v1/audio/transcriptions");
    var request = http.MultipartRequest('POST', url);
    request.headers.addAll(({"Authorization": "Bearer $apiKey"}));
    request.fields["model"] = 'whisper-1';
    request.fields["language"] = "en";
    request.files.add(await http.MultipartFile.fromPath('file', filePath));
    var response = await request.send();
    var newresponse = await http.Response.fromStream(response);
    final responseData = json.decode(newresponse.body);

    return responseData['text'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: app,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Audio To Text ",
          style: TextStyle(color: txt, fontSize: 28),
        ),
        backgroundColor: l1,
      ),
      body: SizedBox.expand(child: content()),
    );
  }

  Widget content() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/a.gif"),
          fit: BoxFit.cover,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result =
                  await FilePicker.platform.pickFiles();
                  if (result != null) {
                    //call openai's transcription api
                    convertSpeechToText(result.files.single.path!).then((value) {
                      setState(() {
                        text = value;
                      });
                    });
                  }
                },
                child: Text(
                  'Extract ',
                  style: TextStyle(color: txt, fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(backgroundColor: l1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Speech to Text: \n$text",
                style: TextStyle(fontSize: 23, color: txt,fontWeight: FontWeight.bold,),
              ),
            )
          ],
        ),
      ),
    );
  }
}
