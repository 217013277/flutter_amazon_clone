import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/utils.dart';

import '../../../constants/config.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required int quatity,
    required String category,
    required List<File> images,
  }) async {
    try {
      final cloudinary = CloudinaryPublic(cloudName, uploadPreset);
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path,
              folder: name, resourceType: CloudinaryResourceType.Image),
        );
        imageUrls.add(res.secureUrl);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
