import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  final Function _selectImage;

  const ImageInput(this._selectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _showedImage;

  Future<void> _takePicture() async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (pickedFile == null) {
      return;
    }

    setState(() {
      _showedImage = File(pickedFile.path);
    });

    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(pickedFile.path);
    final savedImage =
        await File(pickedFile.path).copy('${appDir.path}/$fileName');

    widget._selectImage(savedImage);
  }

  Future<void> _openImageFromGallery() async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );

    if (pickedFile == null) {
      return;
    }

    setState(() {
      _showedImage = File(pickedFile.path);
    });

    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(pickedFile.path);
    final savedImage =
        await File(pickedFile.path).copy('${appDir.path}/$fileName');

    widget._selectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _showedImage != null
              ? Image.file(
                  _showedImage,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : Text(
                  'No Image Selected',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            children: [
              FlatButton.icon(
                icon: Icon(Icons.camera_alt),
                label: Text('Take Picture'),
                textColor: Theme.of(context).primaryColor,
                onPressed: _takePicture,
              ),
              FlatButton.icon(
                icon: Icon(Icons.image),
                label: Text('From Gallery'),
                textColor: Theme.of(context).primaryColor,
                onPressed: _openImageFromGallery,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
