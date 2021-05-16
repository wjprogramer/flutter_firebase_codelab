import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final Function? onTap;
  final String? avatarUrl;

  Avatar({
    this.onTap,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final avatarMarginValue = onTap != null ? 5.0 : 0.0;

    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: avatarMarginValue,
              right: avatarMarginValue,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size.width),
              border: Border.all(color: Colors.grey),
            ),
            child: ClipOval(
              child: _avatarImage(),
            ),
          ),
          if (onTap != null)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.width),
                  color: Theme.of(context).primaryColor,
                ),
                child: Icon(
                  Icons.edit,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _avatarImage() {
    return LayoutBuilder(builder: (ctx, constraints) {
      if (avatarUrl == null) {
        return Container(
          height: constraints.maxWidth,
          width: constraints.maxWidth,
          color: Theme.of(ctx).primaryColorLight,
        );
      } else {
        return Image.network(
          avatarUrl!,
          height: constraints.maxWidth,
          width: constraints.maxWidth,
          fit: BoxFit.cover,
        );
      }
    });
  }
}
