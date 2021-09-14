import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SimplePlayerAvatar extends StatelessWidget {
  final String? _url;

  SimplePlayerAvatar(this._url);

  @override
  Widget build(BuildContext context) {
    ImageProvider image;
    if (_url == null) {
      image = AssetImage('icons/ic_player_image_ph.png');
    } else {
      image = NetworkImage(_url!);
    }
    return CircleAvatar(foregroundImage: image, backgroundColor: Colors.white);
  }
}
