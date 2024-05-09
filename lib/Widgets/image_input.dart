import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageInput extends StatefulWidget {
  final Function(String)? onImageSelected;

  const ImageInput({Key? key, this.onImageSelected}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  Future<void> _takePicture() async {
    final imagePicker = ImagePicker();

    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (pickedImage == null) {
      return;
    }

    final imageFile = File(pickedImage.path);

    try {
      final ref = FirebaseStorage.instance.ref().child('images/${DateTime.now().toIso8601String()}');
      await ref.putFile(imageFile);

      final imageUrl = await ref.getDownloadURL();

      if (widget.onImageSelected != null) {
        widget.onImageSelected!(imageUrl);
      }

      setState(() {
        _selectedImage = imageFile;
      });
    } catch (error) {
      print('Error uploading image: $error');
    }
  }

  Future<void> _viewImage() async {
    if (_selectedImage == null) {
      return;
    }

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageViewScreen(image: _selectedImage!),
      ),
    );

    setState(() {
      _selectedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: _takePicture,
      icon: const Icon(Icons.camera),
      label: const Text('Take Picture'),
    );
    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: _viewImage,
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }
    return Container(
      height: 100,
      width: double.infinity,
      alignment: Alignment.center,
      child: content,
    );
  }
}

class ImageViewScreen extends StatelessWidget {
  final File image;

  const ImageViewScreen({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.file(image),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Retake'),
            ),
          ],
        ),
      ),
    );
  }
}
