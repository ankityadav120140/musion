import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:url_launcher/url_launcher.dart';

class EmotionScreen extends StatefulWidget {
  final String imagePath;

  EmotionScreen({required this.imagePath});

  @override
  State<EmotionScreen> createState() => _EmotionScreenState();
}

class _EmotionScreenState extends State<EmotionScreen> {
  String output = '';
  List prediction = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadModel();
  }

  runModel() async {
    prediction.clear();
    prediction = (await Tflite.runModelOnImage(
      path: widget.imagePath,
      // path: "assets/vkSmile.jpg",
    ))!;

    print("Pred0********${prediction[0]}*************");
    print(prediction.length);
    print("Pred1********${prediction[1]}*************");

    setState(() {
      output = prediction[0]['label'];
      print(output);
    });

    if (output == '1 Sad') {
      const url = 'https://www.youtube.com/results?search_query=sad+song';
      final Uri _url = Uri.parse(url);
      if (!await launchUrl(_url)) {
        throw Exception('Could not launch $_url');
      }
    } else {
      const url = 'https://www.youtube.com/results?search_query=happy+song';
      final Uri _url = Uri.parse(url);
      if (!await launchUrl(_url)) {
        throw Exception('Could not launch $_url');
      }
    }

    // if (prediction[0]['confidence'] - prediction[1]['confidence'] < 0) {
    //   setState(() {
    //     output = "Happy";
    //     // prediction.clear();
    //   });
    // } else {
    //   setState(() {
    //     output = "Sad";
    //     // prediction.clear();
    //   });
    // }
    // for (var element in prediction) {
    //   setState(() {

    //     output = element['label'];
    //   });
    //   print("******test:$element*******");
    // }
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
    print("************Model loaded**********");
    runModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detecting Emotion'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.file(File(widget.imagePath)),
            SizedBox(height: 20),
            output == '' ? Text('Analyzing...') : Text(output),
            // TextButton(
            //     onPressed: () async {
            //       await Tflite.close();
            //       print("***CLOSED SUCCESSFULLY****");
            //     },
            //     child: Text('Cancel,'))
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //     child: Text("Detect"),
      //     onPressed: () async {
      //       runModel();
      //     }),
    );
  }
}
