import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_codelab/services/avatar_service.dart';
import 'package:flutter_firebase_codelab/widgets/avatar.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';

class MyInformationCard extends StatefulWidget {
  final User? user;

  MyInformationCard({ this.user });

  @override
  _MyInformationCardState createState() => _MyInformationCardState();
}

class _MyInformationCardState extends State<MyInformationCard> {
  final _avatarService = GetIt.instance<AvatarService>();

  User? _user;
  String? _avatarUrl;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    _user = widget.user;
    _avatarUrl = await _avatarService.getAvatarImageUrl(_user);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          SizedBox(width: 16,),
          Expanded(
            child: Avatar(
              avatarUrl: _avatarUrl,
              onTap: () async {
                var image = await getImage();
                if (image != null) {
                  await _avatarService.uploadAvatar(image, _user);
                }
              },
            ),
          ),
          SizedBox(width: 24,),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _user?.displayName ?? 'Unknown',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _user?.email ?? 'No provided email',
                ),
              ],
            ),
          ),
          SizedBox(width: 16,),
        ],
      ),
    );
  }

  Future<File?> getImage() async {
    final image = await ImagePickerGC.pickImage(
        enableCloseButton: true,
        context: context,
        source: ImgSource.Both,
        barrierDismissible: true,
    );
    if (image != null) {
      final path = image.path;
      return File(path);
    }
    return null;
  }

}
