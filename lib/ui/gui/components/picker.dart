import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Picker extends StatelessWidget {
  final ValueSetter<List<XFile>>? onPicked;
  final ImagePicker _picker = ImagePicker();

  Picker({super.key, this.onPicked});

  Future<void> _pickImageFromCamera() async {
    var file = await _picker.pickImage(source: ImageSource.camera);

    if(file == null) {
      return;
    }

    onPicked?.call(List.of({file}));
  }

  Future<void> _pickImageFromGallery() async {
    var images = await _picker.pickMultiImage();

    if(images.isEmpty) {
      return;
    }

    onPicked?.call(images);
  }

  Future<void> _pickImages(BuildContext context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              _pickImageFromCamera();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Gallery'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              _pickImageFromGallery();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async => _pickImages(context),
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(20),
      ),
      child: const Icon(
        Icons.camera,
      ),
    );
  }
}
