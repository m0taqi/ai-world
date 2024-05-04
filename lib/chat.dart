import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'const.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _response = "";
  bool _isLoading = false;

  Future<String> getResponseFromAPI(String search) async {
    try {
      String apiKey = "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";
      var url = Uri.https("api.openai.com", "/v1/completions");

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      };

      Map<String, dynamic> body = {
        "model": 'text-davinci-003',
        "prompt": search,
        "max_tokens": 2000,
      };

      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);
        return responseJson["choices"][0]["text"];
      } else {
        throw Exception("Failed to get response from API");
      }
    } catch (e) {
      print("Caught exception: $e");
      return "";
    }
  }

  void _getResponse() async {
    setState(() {
      _isLoading = true;
    });

    try {
      String response =
          await getResponseFromAPI(_searchController.text.toString());
      setState(() {
        _response = response;
      });
    } catch (e) {
      _response = e.toString();
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: app,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "AI ChatBot",
          style: TextStyle(color: Color(0xffbde0fe), fontSize: 28),
        ),
        backgroundColor: back,
      ),
      body:
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(screenHeight / 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(style: TextStyle(color: txt,fontSize: 20),
                controller: _searchController,
                decoration:  InputDecoration(
                  hintText: 'How I Can Help You!',hintStyle: TextStyle(color: txt)
                ),
              ),
              SizedBox(height: screenHeight / 30),
              _isLoading
                  ?  CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _getResponse,
                      child:  Text(
                        "Get Result",
                        style: TextStyle(
                            color: txt,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: back
                      ),
                    ),
              SizedBox(height: screenHeight / 30),
              Card(
                color: tex,
                child: _response.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.only(
                          top: 0,
                          left: screenHeight / 50,
                          right: screenHeight / 50,
                          bottom: screenHeight / 20,
                        ),
                        child: Text(_response, style: TextStyle(color: txt,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
