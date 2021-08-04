import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImagePickerProvider {
  static ImagePickerProviderDialogBox(
      BuildContext context, Function takePicture, getFromGalleryImage) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(
                "Upload Picture",
                style: TextStyle(color: Colors.redAccent),
              ),
              content: Text(
                "Please Upload your pic through your gallery or camera",
              ),
              actions: [
                FlatButton(
                  onPressed: () {
                    takePicture(context);
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Camera",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    getFromGalleryImage(context);
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Gallery",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ));
  }
}
