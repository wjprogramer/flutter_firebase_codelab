import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

abstract class AvatarService {
  Future<File?> downloadAvatar(User? user);
  Future<String?> getAvatarImageUrl(User? user);
  Future<bool> uploadAvatar(File? avatar, User? user);
}