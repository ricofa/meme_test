import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class SharePage extends StatefulWidget {
  final String imageUrl;
  final File image;
  final String text;
  const SharePage({Key? key, required this.imageUrl, required this.image, required this.text}) : super(key: key);

  @override
  State<SharePage> createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  ScreenshotController screenshotController = ScreenshotController();

  Future shareFiles(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/flutter.png');
    image.writeAsBytes(bytes);

    await Share.shareFiles(
      [image.path],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share Page'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Screenshot(
                controller: screenshotController,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.imageUrl),
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: MediaQuery.of(context).size.height / 2.1,
                        left: 10,
                        child: Image.file(
                          widget.image,
                          fit: BoxFit.contain,
                          width: 150,
                          height: 200,
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height / 4,
                        left: 10,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          color: Colors.black.withOpacity(0.5),
                          child: Text(
                            widget.text,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () async {
                final image = await screenshotController.capture();
                shareFiles(image!);
              }, child: Text('Share Files')),
            ],
          )
        ],
      ),
    );
  }
}
