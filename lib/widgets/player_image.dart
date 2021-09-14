import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:live_football_scrolling_poc/constants/colors.dart';

class PlayerImage extends StatelessWidget {
  final double radius;
  final ImageProvider image;

  PlayerImage({required this.image, this.radius = 20.0});

  static const _fallbackImage = const AssetImage('icons/ic_player_image_ph.png');

  static const BoxDecoration _fg = const BoxDecoration(
    shape: BoxShape.circle,
    border: const Border.fromBorderSide(
      const BorderSide(color: AppColors.darkWhite, width: 2.0, style: BorderStyle.solid),
    ),
  );

  PlayerImage.network({
    required String? logoPath,
    this.radius = 20.0,
  }) : this.image = _getImage(logoPath);

  static ImageProvider _getImage(String? logoPath) {
    ImageProvider image;
    if (logoPath == null) {
      image = _fallbackImage;
    } else {
      image = NetworkImage(logoPath);
    }
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      foregroundDecoration: _fg,
      child: CircleAvatar(
        radius: radius - 1,
        foregroundImage: image,
        backgroundColor: AppColors.darkWhite,
      ),
    );
  }
}
