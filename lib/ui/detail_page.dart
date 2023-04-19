import 'dart:io';
import 'dart:ui';

import 'package:algo_test/ui/share_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class DetailPage extends StatefulWidget {
  final String imageUrl;
  const DetailPage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  GlobalKey _globalKey = GlobalKey();
  File? _image;
  final picker = ImagePicker();
  TextEditingController _textEditingController = TextEditingController();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _saveImage() async {
    try {
      RenderRepaintBoundary boundary =
      _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final directory = (await getApplicationDocumentsDirectory()).path;
      final file = File('$directory/meme.png');
      await file.writeAsBytes(pngBytes);

      final result = await ImageGallerySaver.saveImage(pngBytes);
      if (result['isSuccess']) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Gambar berhasil disimpan di galeri.'),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Meme"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: RepaintBoundary(
                key: _globalKey,
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.imageUrl),
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: Stack(
                    children: [
                      if (_image != null)
                        Positioned(
                          top: MediaQuery.of(context).size.height / 2.1,
                          left: 10,
                          child: Image.file(
                            _image!,
                            fit: BoxFit.contain,
                            width: 150,
                            height: 200,
                          ),
                        ),
                      if (_textEditingController.text.isNotEmpty)
                        Positioned(
                          top: MediaQuery.of(context).size.height / 4,
                          left: 10,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            color: Colors.black.withOpacity(0.5),
                            child: Text(
                              _textEditingController.text,
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
          Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                  child: Text('Tambahkan logo dan text sebelum melakukan simpan dan share', style: TextStyle(fontSize: 20, color: Colors.black),)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  (_image != null && _textEditingController.text.isNotEmpty)
                      ? ElevatedButton(
                          onPressed: () {
                            _saveImage();
                          },
                          child: Text(
                            'save',
                            style: TextStyle(color: Colors.white),
                          ))
                      : IconButton(
                          onPressed: () {
                            getImage();
                          },
                          icon: Icon(Icons.add_photo_alternate),
                        ),
                  (_image != null && _textEditingController.text.isNotEmpty)
                      ? ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SharePage(
                                  imageUrl: widget.imageUrl,
                                  image: _image!,
                                  text: _textEditingController.text,
                                ),
                              ),
                            );
                          },
                          child:
                              Text('share', style: TextStyle(color: Colors.white)))
                      : IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Add Text"),
                                  content: TextField(
                                      controller: _textEditingController,
                                      decoration: InputDecoration(
                                        hintText: "Enter text here",
                                      ),
                                      onChanged: (value) {
                                        setState(() {});
                                      }),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.text_fields),
                        ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

}
