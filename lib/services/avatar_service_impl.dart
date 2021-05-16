import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_firebase_codelab/services/avatar_service.dart';

class AvatarServiceImpl extends AvatarService {

  @override
  Future<File?> downloadAvatar(User? user) {
    throw UnimplementedError();
  }

  @override
  Future<String?> getAvatarImageUrl(User? user) async {
    if (user == null) {
      return null;
    }

    var downloadURL = await FirebaseStorage.instance
        .ref(_getAvatarPath(user))
        .getDownloadURL();

     return downloadURL;
  }

  @override
  Future<bool> uploadAvatar(File? avatar, User? user) async {
    try {
      if (avatar == null) {
        return false;
      }

      await FirebaseStorage.instance
          .ref(_getAvatarPath(user!))
          .putFile(avatar);

      return true;
    } on FirebaseException catch (_/* e */) {
      // e.g, e.code == 'canceled'
      return false;
    }
  }

  String _getAvatarPath(User user) {
    return 'users/${user.uid}/avatar.jpg';
  }

}