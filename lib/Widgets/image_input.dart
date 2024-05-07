import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  final User? auth = FirebaseAuth.instance.currentUser!;

  File? _selectedImage;
  void _takePicture() async {
    final imagePicker = ImagePicker();

    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);
        // final galleryIamge = await imagePicker.pickImage(source: ImageSource.gallery, maxWidth: 600);
    if (pickedImage == null) {
      return;
    }
else{
  var imageName = basename(pickedImage.path);
  var RefrenceStorage = FirebaseStorage.instance.ref('${auth!.email}/$imageName');
  await RefrenceStorage.putFile(File(pickedImage.path)); 
  var url = await RefrenceStorage.getDownloadURL();
    
    
    }
    setState(() {
      _selectedImage = File(pickedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: _takePicture,
      icon: const Icon(CupertinoIcons.camera),
      label: const Text(''),
    );
    if (_selectedImage != null) {
      content = GestureDetector(
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
