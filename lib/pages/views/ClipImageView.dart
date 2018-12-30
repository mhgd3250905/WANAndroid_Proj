import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ClipImageView extends StatelessWidget {
  final String imgUrl;
  final BorderRadius borderRadius;

  ClipImageView(this.imgUrl, this.borderRadius);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ClipRRect(
      child: new FadeInImage.memoryNetwork(
        fit: BoxFit.fitWidth,
        placeholder: kTransparentImage,
        image: imgUrl,
      ),
      borderRadius: borderRadius,
    );
  }
}
