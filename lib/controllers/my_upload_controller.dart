import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../model/post_model.dart';
import '../services/db_service.dart';
import '../services/file_service.dart';

class UploadController extends GetxController {
  bool isLoading = false;
  var captionController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  File? image;

  uploadNewPost() {
    String caption = captionController.text.toString().trim();
    if (caption.isEmpty) return;
    if (image == null) return;
    apiPostImage();
  }

  void apiPostImage() {
    isLoading = true;
    update();

    FileService.uploadPostImage(image!).then((downloadUrl) => {
          resPostImage(downloadUrl),
        });
  }

  void resPostImage(String downloadUrl) {
    String caption = captionController.text.toString().trim();
    Post post = Post(caption, downloadUrl);
    apiStorePost(post);
  }

  void apiStorePost(Post post) async {
    // Post to posts
    Post posted = await DBService.storePost(post);
    // Post to feeds
    DBService.storeFeed(posted).then((value) => {
          moveToFeed(),
        });
  }

  moveToFeed(PageController pageController) {
    isLoading = false;
    update();

    captionController.text = "";
    image = null;
    pageController.animateToPage(0,
        duration: const Duration(microseconds: 200), curve: Curves.easeIn);
  }

  imgFromGallery() async {
    XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    image = File(image!.path) as XFile?;
    update();
  }

  imgFromCamera() async {
    XFile? image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    image = File(image!.path) as XFile?;
    update();
  }

  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Pick Photo'),
                  onTap: () {
                    imgFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Take Photo'),
                  onTap: () {
                    imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
}
